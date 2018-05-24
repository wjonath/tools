#!/bin/bash

app_name=`ls *.jar`
app_pid=`ps -ef | grep "$app_name" | grep -v "grep" | awk '{print $2}'`
  
restart_app(){
    stop_app
    echo "restarting..."
    sleep 1s
    app_pid=`ps -ef | grep "$app_name" | grep -v "grep" | awk '{print $2}'`
    start_app
}

stop_app(){
    if [ -n "$app_pid" ]; then
        echo "$app_name is running, pid=$app_pid, now will killed it!"
        kill -9 $app_pid
        echo "stoped!"
    else
        echo "$app_name is not running!!!"
    fi
}

start_app(){
    if [ "$app_pid" == "" ]; then
        echo "$app_name is not running."
        nohup java -jar $app_name & > nohup.out
        app_pid=`ps -ef | grep "$app_name" | grep -v "grep" | awk '{print $2}'`
        echo "pid=$app_pid"
    else
        echo "$app_name is running, pid=$app_pid"
    fi
}

usage(){
    echo "
        -r restart
	-t stop
	-s start
"
}


if [ "$1" == "-s" ]; then
    echo "starting $app_name ..."
    start_app
elif [ "$1" == "-t" ]; then
    echo "stoping $app_name"
    stop_app
elif [ "$1" == "-r" ]; then
    echo "restart $app_name"
    restart_app
else
    usage
fi


