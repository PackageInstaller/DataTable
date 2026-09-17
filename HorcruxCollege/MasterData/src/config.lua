config = {}
config.version = "1.2.14.776"
config.clientbranch = "android3.5"
config.loginurl = "https://horcrux.aojiaostudio.com/login"
config.payurl = "https://horcrux.aojiaostudio.com/purchase"
config.updateurl = "https://horcrux.aojiaostudio.com/update"

if "release" == "debug" then
	config._DEBUG = false
	config._MEM = false
	config._MEM_INTERVAL = 3
	config._PRINT = true
	config.show_display_stats = false
	config._DEBUG_RUNCONSOLE = false

	if config._DEVELOP_MODE == "FIGHTDEV" then
		config._DESIGN_WIDTH = 1920
		config._DESIGN_HEIGHT = 1136
		config._SCREEN_WIDTH = 1920
		config._SCREEN_HEIGHT = 1136
		config._FRAME_ZOOM = 0.8
		config._DEBUG = true
	else
		config._DESIGN_WIDTH = 640
		config._DESIGN_HEIGHT = 1136
		config._SCREEN_WIDTH = 1080
		config._SCREEN_HEIGHT = 2160
		config._FRAME_ZOOM = 0.45
	end

	if config._DEVELOP_MODE == "DATADEV" then
		config._CHECKDATA = false
		config._DISABLE_GAMELOG = false
		config._DEBUG_TALK = false
		config._DEBUG_FIGHT = false
		config._DEBUG_FIGHTRESULT = false
		config._DEBUG_BOSSPREVIEW = false
	end

	config.who_is_your_dady = false
elseif "release" == "release" then
	config._DEBUG = false
	config._MEM = false
	config._MEM_INTERVAL = 10
	config._PRINT = true
	config.show_display_stats = false
	config._DISABLE_GAMELOG = true
	config._DESIGN_WIDTH = 640
	config._DESIGN_HEIGHT = 1136
	config._SCREEN_WIDTH = config._DESIGN_WIDTH
	config._SCREEN_HEIGHT = config._DESIGN_HEIGHT
	config._FRAME_ZOOM = 1
end

if "release" == "debug" then
	config._UPDATE = false
elseif "release" == "release" then
	config._UPDATE = true
end

config.downloadurl = "http://h-college.com"

if "release" == "debug" then
	config.open_guide = true
	config.open_guidefight = true
	config.limit_open_system = true
elseif "release" == "release" then
	config.open_guide = true
	config.open_guidefight = true
	config.limit_open_system = true
end

if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_WINDOWS then
	config._DISABLE_GAMELOG = false
end

config.packagechannel = "feiyu"
config.clientmode = 1
config.needactivate = false
