local var_0_0
local var_0_1 = {}

__G__TRACKBACK__ = __G__TRACKBACK__ or function(arg_1_0)
	if var_0_0 and not var_0_1[var_0_0] then
		var_0_1[var_0_0] = true

		print("__G__TRACKBACK__ = ", var_0_0)
		release_print("__G__TRACKBACK__ = ", var_0_0)

		return
	end

	release_print("__G__TRACKBACK__ = ", var_0_0)

	local device = require("cocos.framework.device")

	if device.isIOS() or device.isAndroid() or device.isOHOS() then
		local var_1_1 = arg_1_0
		local var_1_2 = require("cocos.framework.device")

		if buglyReportLuaException then
			buglyReportLuaException(tostring(var_1_1), debug.traceback())
		end

		print("__G__TRACKBACK__ = ", (debug.traceback("", 3)))
	end

	xpcall(function()
		if g.core.event and g.core.event.EventManager then
			g.core.event.EventManager:dispatchEvent("ON_G_TRACKBACK_CALL")
		end

		require("app.view.module.debug.pop.ErrorMessagePop").popErrorWin(arg_1_0)
	end, function()
		return
	end)

	var_0_0 = arg_1_0
end

local var_0_2 = cc.FileUtils:getInstance()

function __REMOVE_LOCAL_CACHE__()
	local var_4_0 = var_0_2:getWritablePath()

	var_0_2:removeDirectory((uf.UpgradeManager:getInstance():getUpgradeFolder()))
	var_0_2:removeFile(var_4_0 .. "userdata/upgrade_config.json")
	var_0_2:removeDirectory(var_4_0 .. "upgradelang/")
	var_0_2:removeFile(var_4_0 .. "userdata/multilingual.json")
end

_IS_ERROR_START = _IS_ERROR_START or false

var_0_2:setPopupNotify(false)

local function var_0_3()
	require("setup")
	require("cocos.init")
	require("config")
	require("upgrade.Env").enable_global()
	require("upgrade.Env").record_packageload()
	require("battle.init")
	device.setConfigByRegion()

	local var_5_0 = uf.UpgradeManager:getInstance():getUpgradeFolder()

	cc.FileUtils:getInstance():setSearchPaths({
		var_5_0 .. device.srcPath64,
		var_5_0 .. "res/",
		var_5_0 .. "res/common/",
		var_5_0,
		device.hqDirPath .. "res/",
		device.hqDirPath .. "res/common/",
		device.hqDirPath,
		device.obbDirPath .. "res/",
		device.obbDirPath .. "res/common/",
		device.srcPath,
		device.obbDirPath,
		"res/",
		"res/common/"
	})
	require("app.core.lang.MultilingualMgr"):initLangSearchPath()
	require("app.MyApp"):run()
end

xpcall(var_0_3, function(arg_6_0)
	if _IS_ERROR_START then
		return
	end

	__REMOVE_LOCAL_CACHE__()
	__G__TRACKBACK__("on my app launch error: \n" .. arg_6_0)

	_IS_ERROR_START = true

	if device.restartGame then
		device.restartGame()
	else
		for iter_6_0, iter_6_1 in pairs(package.loaded) do
			if type(iter_6_0) == "string" and (string.find(iter_6_0, "app.") ~= nil or string.find(iter_6_0, "battle.") ~= nil or string.find(iter_6_0, "cocos.") ~= nil or string.find(iter_6_0, "patch.") ~= nil or string.find(iter_6_0, "protobuff.") ~= nil or string.find(iter_6_0, "upgrade.") ~= nil) then
				package.loaded[iter_6_0] = nil
			end
		end

		for iter_6_2, iter_6_3 in pairs(package.preload) do
			if type(iter_6_2) == "string" and (string.find(iter_6_2, "app.") ~= nil or string.find(iter_6_2, "battle.") ~= nil or string.find(iter_6_2, "cocos.") ~= nil or string.find(iter_6_2, "patch.") ~= nil or string.find(iter_6_2, "protobuff.") ~= nil or string.find(iter_6_2, "upgrade.") ~= nil) then
				package.preload[iter_6_2] = nil
			end
		end

		var_0_3()
	end
end)
