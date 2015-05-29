#!/bin/sh

sudo apt-get install nginx
sudo apt-get install php5-cli php5-cgi php5-fpm php5-mcrypt php5-mysql php5-gd php-apc php5-common
sudo apt-get install mysql-client-5.5
sudo debconf-set-selections <<< 'mysql-server mysql-server/$1 password $2'
sudo debconf-set-selections <<< 'mysql-server mysql-server/$1 password $2'
sudo apt-get -y install mysql-server

#modify mysql.ini
sed -i'' -e '/bind-address/d' /etc/mysql/my.cnf

#wget nginx default
wget https://raw.githubusercontent.com/seaify/tools/master/files/nginx.phpmyadmin.default -O /etc/nginx/sites-enabled/default

#download phpmyadmin files
cd /usr/share/nginx/html
sudo wget http://superb-dca2.dl.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.4.8/phpMyAdmin-4.4.8-all-languages.tar.bz2
sudo tar xvf phpMyAdmin-4.4.8-all-languages.tar.bz2
sudo mv phpMyAdmin-4.4.8-all-languages.tar phpmyadmin

sudo service nginx reload
sudo service php5-fpm restart

##test with http://ip/phpmyadmin, or http://localhost/phpmyadmin
