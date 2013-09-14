# A Dockerfile to provide an RPM build environment.

FROM centos
MAINTAINER Steven Merrill <steven.merrill@gmail.com>

RUN yum -y localinstall http://mirror.rit.edu/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y update
RUN yum -y install @development mock sudo rpmdevtools
RUN sed -i 's/requiretty/!requiretty/' /etc/sudoers
RUN useradd -d /home/rpmbuild --shell=/bin/bash rpmbuild
RUN sudo -urpmbuild rpmdev-setuptree
RUN sudo -urpmbuild echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros

ENV HOME /home/rpmbuild
USER rpmbuild
WORKDIR /home/rpmbuild/
CMD /bin/bash --login
