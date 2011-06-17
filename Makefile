### Generated by Winemaker 0.7.4


SRCDIR                = .
SUBDIRS               =
DLLS                  =
EXES                  = thred.exe
DESTDIR               = /usr/local



### Common settings

CEXTRA                = -W -fexceptions -g -O0  \
			-mno-cygwin \
			-masm=intel \
			-m32
CXXEXTRA              = -W -fexceptions -g -O0  \
			-mno-cygwin \
			-masm=intel \
			-m32
RCEXTRA               =
DEFINES               = -DWIN32 -D_DEBUG -D_WINDOWS -D_MBCS -DGCC__
INCLUDE_PATH          =
DLL_PATH              = 
DLL_IMPORTS           =
LIBRARY_PATH          = -L.
LIBRARIES             =  -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lodbc32 -lodbccp32 -lhtmlhelp


### thred.exe sources and settings

thred_exe_MODULE      = thred.exe
thred_exe_C_SRCS      =
thred_exe_CXX_SRCS    = ./form.cpp \
			./hlp.cpp \
			./thred.cpp \
			./xt.cpp
thred_exe_RC_SRCS     = ./thred.rc
thred_exe_LDFLAGS     = -mwindows \
			-mno-cygwin \
			-m32
thred_exe_DLL_PATH    =
thred_exe_DLLS        = odbc32 \
			ole32 \
			oleaut32 \
			winspool \
			odbccp32
thred_exe_LIBRARY_PATH=
thred_exe_LIBRARIES   = uuid

thred_exe_OBJS        = $(thred_exe_C_SRCS:.c=.o) \
			$(thred_exe_CXX_SRCS:.cpp=.o) \
			$(thred_exe_RC_SRCS:.rc=.res)



### Global source lists

C_SRCS                = $(thred_exe_C_SRCS)
CXX_SRCS              = $(thred_exe_CXX_SRCS)
RC_SRCS               = $(thred_exe_RC_SRCS)


### Tools

CC = winegcc
CXX = wineg++
RC = wrc


### Generic targets

all: $(SUBDIRS) $(DLLS:%=%.so) $(EXES:%=%.so)

### Build rules

.PHONY: all clean dummy install

$(SUBDIRS): dummy
	@cd $@ && $(MAKE)

# Implicit rules

.SUFFIXES: .cpp .rc .res
DEFINCL = $(INCLUDE_PATH) $(DEFINES) $(OPTIONS)

.c.o:
	$(CC) -c $(CFLAGS) $(CEXTRA) $(DEFINCL) -o $@ $<

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(CXXEXTRA) $(DEFINCL) -o $@ $<

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $(CXXEXTRA) $(DEFINCL) -o $@ $<

.rc.res:
	$(RC) $(RCFLAGS) $(RCEXTRA) $(DEFINCL) -fo$@ $<

# Rules for cleaning

CLEAN_FILES     = y.tab.c y.tab.h lex.yy.c core *.orig *.rej \
                  \\\#*\\\# *~ *% .\\\#*

clean:: $(SUBDIRS:%=%/__clean__) $(EXTRASUBDIRS:%=%/__clean__)
	$(RM) $(CLEAN_FILES) $(RC_SRCS:.rc=.res) $(C_SRCS:.c=.o) $(CXX_SRCS:.cpp=.o)
	$(RM) $(DLLS:%=%.so) $(EXES:%=%.so) 

$(SUBDIRS:%=%/__clean__): dummy
	cd `dirname $@` && $(MAKE) clean

$(EXTRASUBDIRS:%=%/__clean__): dummy
	-cd `dirname $@` && $(RM) $(CLEAN_FILES)

### Target specific build rules
DEFLIB = $(LIBRARY_PATH) $(LIBRARIES) $(DLL_PATH) $(DLL_IMPORTS:%=-l%)

$(thred_exe_MODULE).so: $(thred_exe_OBJS)
	$(CXX) $(thred_exe_LDFLAGS) -o $@ $(thred_exe_OBJS) $(thred_exe_LIBRARY_PATH) $(DEFLIB) $(thred_exe_DLLS:%=-l%) $(thred_exe_LIBRARIES:%=-l%)

#patch tchar.h
tchar.h: /usr/include/wine/windows/tchar.h
	sed -e 's/#if defined(_UNICODE) || defined(_MBCS)/#if (defined(_UNICODE) || defined(_MBCS)) \&\& !defined(__MSVCRT__)/' /usr/include/wine/windows/tchar.h > tchar.h

form.o hlp.o thred.o xt.o: tchar.h
form.o thred.o: bits.h

install: all
	mkdir -p ${DESTDIR}/bin
	install -t ${DESTDIR}/bin thred thred.exe.so 
