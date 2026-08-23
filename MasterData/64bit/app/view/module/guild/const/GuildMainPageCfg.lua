return {
	{
		scale = 0.9,
		index = 1,
		icon = "ui://guild/icon_jt_gonghuishangdian",
		function_id = 0,
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
		scale = 0.9,
		icon = "ui://guild/icon_jt_shiwudating",
		function_id = 0,
		index = 2,
		redPointId = 285,
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
		scale = 0.9,
		icon = "ui://guild/icon_jt_zhizhanzhongxin",
		function_id = 0,
		index = 3,
		redPointId = 183,
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
		icon = "ui://guild/icon_jt_gaonengfanyingdui",
		redPointId = 279,
		function_id = 0,
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
		scale = 0.9,
		icon = "ui://guild/icon_jt_gonghuidating",
		function_id = 0,
		index = 5,
		redPointId = 274,
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
		icon = "ui://guild/icon_jt_buliepingtai",
		function_id = 0,
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
