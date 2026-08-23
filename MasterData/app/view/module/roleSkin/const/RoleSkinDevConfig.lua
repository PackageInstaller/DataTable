local var_0_0 = {
	DEV_TYPE = {
		STAGE = 2,
		LEVEL = 1
	}
}

var_0_0.DEV_LIST = {
	[var_0_0.DEV_TYPE.LEVEL] = {
		comp = "roleSkin/RoleSkinStrengthenComp",
		newRedPointId = 879,
		normalIcon = "ui://base_new/icon_zbpy_qianghua_2",
		selectIcon = "ui://base_new/icon_zbpy_qianghua_1",
		title = g.core.lang:get(201511),
		cond = function()
			return "", true
		end,
		show = function()
			return "", true
		end,
		index = var_0_0.DEV_TYPE.LEVEL
	},
	[var_0_0.DEV_TYPE.STAGE] = {
		comp = "roleSkin/RoleSkinStageUpComp",
		newRedPointId = 880,
		normalIcon = "ui://base_new/icon_yht_tupo_2",
		selectIcon = "ui://base_new/icon_yht_tupo_1",
		title = g.core.lang:get(430515),
		cond = function()
			return "", true
		end,
		show = function()
			return "", true
		end,
		index = var_0_0.DEV_TYPE.STAGE
	}
}

return var_0_0
