return {
	run = function(arg_1_0)
		if config.INITBUGLY_IMMEDIATELY and registerBugly then
			registerBugly()

			if buglySetAppVersion then
				buglySetAppVersion(config.GAME_VERSION_NO)
			end
		end

		math.randomseed(tostring(cc.utils.gettime()):reverse():sub(1, 7))
		cc.Director:getInstance():setAnimationInterval(0.03333333333333333)
		cc.Director:getInstance():setDisplayStats(false)
		cc.Device:setKeepScreenOn(true)

		if not BLog then
			require("battle.core.BattleLog")
		end

		require("app.core.fairygui.init")
		fgui.initGameUI()

		local var_1_0 = require("app.PackageManager").new("app", (require("app.package")))

		var_1_0:load()
		require("upgrade.Env").disable_global()

		if device.isWindowsDebug() then
			require("debug.Watcher").init()
		end

		if require("app.view.module.debug.common.DebugCommon").isDebugUpgradeClose() then
			config.UPGRADE_ENABLED = false
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.INIT_GAME_MODULE
		})
		g.core.shader.ShaderMgr:loadShaders()
		g.core.service.ServiceManager:launch()

		local var_1_1 = json.decodeFileIfExists("version.json")

		if device.isWindowsDebug() and var_1_1 then
			local var_1_2 = fgui.GBasicTextField:create()

			var_1_2:setFontSize(22)
			var_1_2:setText(string.format("Version: %s_%s_%s", var_1_1.cpp_version, var_1_1.lua_version, var_1_1.branch))
			var_1_2:setColor(cc.c4b(255, 255, 255, 255))
			var_1_2:enableOutline(2, cc.c4b(0, 0, 0, 255))
			g.core.layer.LayerManager:getRoot():addChild(var_1_2)
			var_1_2:setPivot(0, 1, true)
			var_1_2:setPosition(0, display.height - 85)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.INIT_GAME_MODULE_FINISH
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LAUNCH, false, var_1_0)

		if config.DEBUG_VERSION and not device.isWindows() then
			pcall(function()
				require("poco.poco_manager"):init_server(15004)
			end)
		end
	end
}
