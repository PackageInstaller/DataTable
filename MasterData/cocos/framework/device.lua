local var_0_0 = {}

var_0_0.platform = "unknown"
var_0_0.model = "unknown"

local var_0_1 = cc.Application:getInstance()
local var_0_2 = var_0_1:getTargetPlatform()

if var_0_2 == cc.PLATFORM_OS_WINDOWS then
	var_0_0.platform = "windows"
elseif var_0_2 == cc.PLATFORM_OS_MAC then
	var_0_0.platform = "mac"
elseif var_0_2 == cc.PLATFORM_OS_ANDROID then
	var_0_0.platform = "android"
elseif var_0_2 == cc.PLATFORM_OS_IPHONE or var_0_2 == cc.PLATFORM_OS_IPAD then
	var_0_0.platform = "ios"

	local var_0_3 = cc.Director:getInstance():getOpenGLView():getFrameSize()

	if var_0_3.width == 640 and var_0_3.height == 960 then
		var_0_0.model = "iphone 4"
	elseif var_0_3.width == 640 and var_0_3.height == 1136 then
		var_0_0.model = "iphone 5"
	elseif var_0_3.width == 750 and var_0_3.height == 1334 then
		var_0_0.model = "iphone 6"
	elseif var_0_3.width == 1242 and var_0_3.height == 2208 then
		var_0_0.model = "iphone 6 plus"
	elseif var_0_3.width == 768 and var_0_3.height == 1024 then
		var_0_0.model = "ipad"
	elseif var_0_3.width == 1536 and var_0_3.height == 2048 then
		var_0_0.model = "ipad retina"
	end
elseif var_0_2 == cc.PLATFORM_OS_WINRT then
	var_0_0.platform = "winrt"
elseif var_0_2 == cc.PLATFORM_OS_WP8 then
	var_0_0.platform = "wp8"
elseif var_0_2 == cc.PLATFORM_OS_OHOS then
	var_0_0.platform = "ohos"
end

local var_0_4 = var_0_1:getCurrentLanguage()

var_0_4 = var_0_4 == cc.LANGUAGE_CHINESE and "cn" or var_0_4 == cc.LANGUAGE_FRENCH and "fr" or var_0_4 == cc.LANGUAGE_ITALIAN and "it" or var_0_4 == cc.LANGUAGE_GERMAN and "gr" or var_0_4 == cc.LANGUAGE_SPANISH and "sp" or var_0_4 == cc.LANGUAGE_RUSSIAN and "ru" or var_0_4 == cc.LANGUAGE_KOREAN and "kr" or var_0_4 == cc.LANGUAGE_JAPANESE and "jp" or var_0_4 == cc.LANGUAGE_HUNGARIAN and "hu" or var_0_4 == cc.LANGUAGE_PORTUGUESE and "pt" or var_0_4 == cc.LANGUAGE_ARABIC and "ar" or "en"
var_0_0.language = var_0_4
var_0_0.writablePath = cc.FileUtils:getInstance():getWritablePath()
var_0_0.directorySeparator = "/"
var_0_0.pathSeparator = ":"

if var_0_0.platform == "windows" then
	var_0_0.directorySeparator = "\\"
	var_0_0.pathSeparator = ";"
end

local var_0_6 = "src/"

if var_0_1:is64BitIOSDevice() and (var_0_0.platform == "android" or var_0_0.platform == "ios") then
	var_0_6 = "src/64bit/"
elseif var_0_0.platform == "ohos" then
	var_0_6 = "src/64bit/"
end

var_0_0.srcPath64 = var_0_6
var_0_0.srcPath = var_0_6
var_0_0.obbDirPath = var_0_0.writablePath .. "obb/"
var_0_0.hqDirPath = var_0_0.writablePath .. "hq/"

printInfo("# device.platform              = " .. var_0_0.platform)
printInfo("# device.model                 = " .. var_0_0.model)
printInfo("# device.language              = " .. var_0_0.language)
printInfo("# device.writablePath          = " .. var_0_0.writablePath)
printInfo("# device.directorySeparator    = " .. var_0_0.directorySeparator)
printInfo("# device.pathSeparator         = " .. var_0_0.pathSeparator)
printInfo("# device.srcPath               = " .. var_0_0.srcPath)
printInfo("# device.srcPath64             = " .. var_0_0.srcPath64)
printInfo("# device.obbDirPath            = " .. var_0_0.obbDirPath)
printInfo("# device.hqDirPath             = " .. var_0_0.hqDirPath)
printInfo("#")

function var_0_0.restartGame()
	if config.PCSDK_ENABLED then
		if g.core.platform.PlatformProxy.restartGame then
			g.core.platform.PlatformProxy:restartGame()
		else
			cc.Director:getInstance():endToLua()
		end

		return
	end

	fgui.GRoot:getInstance():getActionManager():removeAllActions()
	fgui.UIPackage:removeAllPackages()

	local var_1_0 = cc.Director:getInstance()

	var_1_0:setFroceFree(true)
	var_1_0:purgeCachedData()
	var_1_0:setFroceFree(false)
	cc.SpriteFrameCache:getInstance():removeSpriteFrames()
	var_1_0:getTextureCache():removeAllTextures()
	g.core.sound.SoundManager:stop()
	g.core.service.ServiceManager:getServiceByName("LaunchService"):clearPackageManager()
	require("upgrade.Env").reset_packageload()
	require("upgrade.Env").reset_globals()
	var_0_0.clearLua()
	print("----reboot game----")

	local var_1_1 = uf.UpgradeManager:getInstance():getUpgradeFolder()

	cc.FileUtils:getInstance():setSearchPaths({
		var_1_1 .. var_0_0.srcPath64,
		var_1_1 .. "res/",
		var_1_1 .. "res/common/",
		var_1_1,
		var_0_0.hqDirPath .. "res/",
		var_0_0.hqDirPath .. "res/common/",
		var_0_0.hqDirPath,
		var_0_0.obbDirPath .. "res/",
		var_0_0.obbDirPath .. "res/common/",
		var_0_0.srcPath,
		var_0_0.obbDirPath,
		"res/",
		"res/common/"
	})
	require("app.core.lang.MultilingualMgr"):initLangSearchPath()

	var_0_0.bRestartGame = true

	require("main")
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
		event_id = g.core.const.ConstMgr.SuperSdkConst.INNER_UPDATE_SUCCESS_RESTART
	})
end

function var_0_0.clearLua(arg_2_0)
	if not arg_2_0 then
		package.loaded.main = nil
	end

	for iter_2_0, iter_2_1 in pairs(package.loaded) do
		if type(iter_2_0) == "string" and (string.find(iter_2_0, "app.") ~= nil or string.find(iter_2_0, "battle.") ~= nil or string.find(iter_2_0, "debug.") ~= nil or string.find(iter_2_0, "poco.") ~= nil or string.find(iter_2_0, "cocos.") ~= nil or string.find(iter_2_0, "patch.") ~= nil or string.find(iter_2_0, "protobuff.") ~= nil or string.find(iter_2_0, "upgrade.") ~= nil) then
			package.loaded[iter_2_0] = nil
		end
	end

	for iter_2_2, iter_2_3 in pairs(package.preload) do
		if type(iter_2_2) == "string" and (string.find(iter_2_2, "app.") ~= nil or string.find(iter_2_2, "battle.") ~= nil or string.find(iter_2_2, "debug.") ~= nil or string.find(iter_2_2, "poco.") ~= nil or string.find(iter_2_2, "cocos.") ~= nil or string.find(iter_2_2, "patch.") ~= nil or string.find(iter_2_2, "protobuff.") ~= nil or string.find(iter_2_2, "upgrade.") ~= nil) then
			package.preload[iter_2_2] = nil
		end
	end

	collectgarbage("collect")
end

function var_0_0.setConfigByRegion()
	local PlatformConst = require("app.core.platform.const.PlatformConst")

	if config.USE_REGION_CFG and config.PUBLISH_REGION then
		if PlatformConst.REGION_CFG[config.PUBLISH_REGION] then
			for iter_3_0, iter_3_1 in pairs(PlatformConst.REGION_CFG[config.PUBLISH_REGION]) do
				if iter_3_0 ~= "PRIVATE_POLICY_URL" and iter_3_0 ~= "USER_SERVICE_URL" or config[iter_3_0] == "" then
					config[iter_3_0] = iter_3_1
				end
			end
		end
	end

	if var_0_0.isSdkEnabled() then
		for iter_3_2, iter_3_3 in pairs(PlatformConst.REGION) do
			PlatformConst.REGION_CFG[iter_3_3].GAME_SECRET = "1"
		end

		config.GAME_SECRET = "1"
	end

	if var_0_0.checkRegionConfig then
		var_0_0.checkRegionConfig()
	end

	dump("cur config is:")
	dump(config)
end

function var_0_0.checkRegionConfig()
	print("device.checkRegionConfig")

	local PlatformConst = require("app.core.platform.const.PlatformConst")

	BATTLE_CONFIG_TYPE.isOs = config.PUBLISH_REGION == PlatformConst.REGION.JAPAN or config.PUBLISH_REGION == PlatformConst.REGION.SEA or config.PUBLISH_REGION == PlatformConst.REGION.TW
end

function var_0_0.isLowGradeDevice()
	return false
end

function var_0_0.isWindows()
	return var_0_0.platform == "windows"
end

function var_0_0.isAndroid()
	return var_0_0.platform == "android"
end

function var_0_0.isIOS()
	return var_0_0.platform == "ios"
end

function var_0_0.isMac()
	return var_0_0.platform == "mac"
end

function var_0_0.isOHOS()
	return var_0_0.platform == "ohos"
end

function var_0_0.isWindowsDebug()
	return var_0_0.isWindows() and config.DEBUG_VERSION
end

function var_0_0.isSdkEnabled()
	return config.SUPERSDK_ENABLED or config.PCSDK_ENABLED
end

function var_0_0.getSdkVersionCode()
	if var_0_1.getSDKVersionCode then
		return var_0_1:getSDKVersionCode()
	end

	return 0
end

function var_0_0.getVersion()
	if var_0_1.getVersion then
		return var_0_1:getVersion()
	end

	return "0"
end

function var_0_0.getVersionCode()
	if var_0_1.getVersionCode then
		return var_0_1:getVersionCode()
	end

	return 0
end

return var_0_0
