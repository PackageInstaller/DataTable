return {
	{
		index = 1,
		function_id = 0,
		scale = 0.9,
		icon = "ui://guild/icon_jt_gonghuishangdian",
		name = g.core.lang:get(109623),
		englishName = g.core.lang:get(109627),
		isOpen = function()
			return true
		end,
		onClick = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
				tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
				shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GUILD
			})
			g.core.resource.ResourceManager:clearResource()
		end
	},
	{
		index = 2,
		function_id = 0,
		redPointId = 285,
		icon = "ui://guild/icon_jt_shiwudating",
		scale = 0.9,
		name = g.core.lang:get(109622),
		englishName = g.core.lang:get(109628),
		isOpen = function()
			return true
		end,
		onClick = function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.GUILD_TASK)
		end
	},
	{
		index = 3,
		function_id = 0,
		redPointId = 183,
		icon = "ui://guild/icon_jt_zhizhanzhongxin",
		scale = 0.9,
		name = g.core.lang:get(109624),
		englishName = g.core.lang:get(109629),
		isOpen = function()
			return true
		end,
		onClick = function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.GUILD_CAMPAIGN)
		end
	},
	{
		index = 4,
		redPointId = 279,
		function_id = 0,
		icon = "ui://guild/icon_jt_gaonengfanyingdui",
		name = g.core.lang:get(109620),
		englishName = g.core.lang:get(109630),
		isOpen = function()
			return true
		end,
		onClick = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_STATUE) then
				g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.GUILD_STATUE)
			end
		end
	},
	{
		index = 5,
		function_id = 0,
		redPointId = 274,
		icon = "ui://guild/icon_jt_gonghuidating",
		scale = 0.9,
		name = g.core.lang:get(109621),
		englishName = g.core.lang:get(109631),
		isOpen = function()
			return true
		end,
		onClick = function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.GUILD_HALL)
		end
	},
	{
		index = 6,
		function_id = 0,
		icon = "ui://guild/icon_jt_buliepingtai",
		name = g.core.lang:get(109626),
		englishName = g.core.lang:get(109632),
		isOpen = function()
			return false
		end,
		onClick = function()
			return
		end
	}
}
