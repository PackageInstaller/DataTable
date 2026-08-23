local var_0_0 = {
	DEV_TYPE = {
		INCREASE = 2,
		TRANS = 1
	},
	RECYCLE_BAN_TYPE = {
		DAILY = 2,
		LIFE = 1,
		NONE = 0,
		MONTHLY = 4,
		WEEKLY = 3
	}
}

var_0_0.DEV_LIST = {
	[var_0_0.DEV_TYPE.TRANS] = {
		topBar = 352,
		newRedPointId = 0,
		selectIcon = "ui://recycleCultivate/icon_sjjx_zhuanhua_1",
		selIndex = 0,
		normalIcon = "ui://recycleCultivate/icon_sjjx_zhuanhua_2",
		comp = "",
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
		topBar = 353,
		newRedPointId = 884,
		selectIcon = "ui://recycleCultivate/icon_sjjx_zengfu_1",
		selIndex = 1,
		normalIcon = "ui://recycleCultivate/icon_sjjx_zengfu_2",
		comp = "",
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
