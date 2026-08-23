local var_0_0 = {
	DEV_TYPE = {
		TRANS = 1,
		INCREASE = 2
	},
	RECYCLE_BAN_TYPE = {
		WEEKLY = 3,
		LIFE = 1,
		MONTHLY = 4,
		DAILY = 2,
		NONE = 0
	}
}

var_0_0.DEV_LIST = {
	[var_0_0.DEV_TYPE.TRANS] = {
		comp = "",
		selIndex = 0,
		topBar = 352,
		newRedPointId = 0,
		normalIcon = "ui://recycleCultivate/icon_sjjx_zhuanhua_2",
		selectIcon = "ui://recycleCultivate/icon_sjjx_zhuanhua_1",
		title = g.core.lang:get(430704),
		cond = function()
			return true, true
		end,
		show = function()
			return #g.core.model.User.recycleCultivateData:getRecycleInfo() > 0
		end,
		index = var_0_0.DEV_TYPE.TRANS
	},
	[var_0_0.DEV_TYPE.INCREASE] = {
		comp = "",
		selIndex = 1,
		topBar = 353,
		newRedPointId = 884,
		normalIcon = "ui://recycleCultivate/icon_sjjx_zengfu_2",
		selectIcon = "ui://recycleCultivate/icon_sjjx_zengfu_1",
		title = g.core.lang:get(430705),
		cond = function()
			return true, true
		end,
		show = function()
			return true
		end,
		index = var_0_0.DEV_TYPE.INCREASE
	}
}

return var_0_0
