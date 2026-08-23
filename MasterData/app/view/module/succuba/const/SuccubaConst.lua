local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local BattleAttr = require("battle.const.BattleAttr")
local var_0_3 = {
	ABLE_FRAGMENT_TYPE = 138,
	STAR_MAX = 7,
	FORMAT_SUCCUBA_NUM_MAX = 3,
	ROOM_MAX_NUM = 5,
	DEV_TYPE = {
		INFO = 1,
		ADV_UP = 4,
		LV_UP = 2,
		STAR_UP = 3
	},
	LV_ATTR_TYPE = {
		{
			key = "hp",
			type = BattleAttr.INITIAL_HP
		},
		{
			key = "attack",
			type = BattleAttr.ATTACK
		},
		{
			key = "physical_defence",
			type = BattleAttr.PHY_DEFENCE
		},
		{
			key = "magical_defence",
			type = BattleAttr.MAG_DEFENCE
		}
	},
	STAR_ATTR_TYPE = {
		{
			key = "base_hp",
			type = BattleAttr.INITIAL_HP
		},
		{
			key = "base_attack",
			type = BattleAttr.ATTACK
		},
		{
			key = "base_physical_defence",
			type = BattleAttr.PHY_DEFENCE
		},
		{
			key = "base_magical_defence",
			type = BattleAttr.MAG_DEFENCE
		}
	},
	PARAMETER_ID = {
		FIRST_INTERACTION_DEFAULT_QUALITY_ID = 3,
		AUTO_INTERACTION_TIME_ID = 5,
		FORMATION_MAX_ID = 6,
		CHAT_AI_EXP_TIMES = 1,
		INTERACTION_EXP_ID = 2,
		INTERACTION_TIMES_ID = 4
	},
	AI_KEY = {}
}

var_0_3.DEV_ARR = {
	[var_0_3.DEV_TYPE.INFO] = {
		comp = "succuba/SuccubaInfoComp",
		resInfoId = 357,
		normalIcon = "ui://base_new/icon_yht_xinxi_2",
		selectIcon = "ui://base_new/icon_yht_xinxi_1",
		title = g.core.lang:get(431005),
		cond = function()
			return var_0_0:getUnlockComment(var_0_1.SUCCUBA)
		end,
		show = function()
			return var_0_0:isModuleShow(var_0_1.SUCCUBA)
		end,
		index = var_0_3.DEV_TYPE.INFO,
		pos = {
			x = 0,
			y = 10
		},
		sound = g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_03
	},
	[var_0_3.DEV_TYPE.LV_UP] = {
		comp = "succuba/SuccubaLvUpComp",
		resInfoId = 358,
		newRedPointId = 894,
		normalIcon = "ui://succuba/icon_mnzj_yc_tiaoli2",
		selectIcon = "ui://succuba/icon_mnzj_yc_tiaoli1",
		title = g.core.lang:get(431006),
		cond = function()
			return var_0_0:getUnlockComment(var_0_1.SUCCUBA)
		end,
		show = function()
			return var_0_0:isModuleShow(var_0_1.SUCCUBA)
		end,
		index = var_0_3.DEV_TYPE.LV_UP,
		pos = {
			x = 0,
			y = 20
		},
		sound = g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_03
	},
	[var_0_3.DEV_TYPE.STAR_UP] = {
		comp = "succuba/SuccubaStarUpComp",
		resInfoId = 359,
		newRedPointId = 895,
		normalIcon = "ui://base_new/icon_yht_shengxing_2",
		selectIcon = "ui://base_new/icon_yht_shengxing_1",
		title = g.core.lang:get(431007),
		cond = function()
			return var_0_0:getUnlockComment(var_0_1.SUCCUBA)
		end,
		show = function()
			return var_0_0:isModuleShow(var_0_1.SUCCUBA)
		end,
		index = var_0_3.DEV_TYPE.STAR_UP,
		pos = {
			x = 0,
			y = 20
		},
		sound = g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_03
	},
	[var_0_3.DEV_TYPE.ADV_UP] = {
		comp = "succuba/SuccubaAdvUpComp",
		resInfoId = 366,
		newRedPointId = 919,
		normalIcon = "ui://succuba/icon_mnzj_yc_zhiyv2",
		selectIcon = "ui://succuba/icon_mnzj_yc_zhiyv1",
		title = g.core.lang:get(431047),
		cond = function()
			return var_0_0:getUnlockComment(var_0_1.SUCCUBA)
		end,
		show = function()
			return var_0_0:isModuleShow(var_0_1.SUCCUBA)
		end,
		index = var_0_3.DEV_TYPE.ADV_UP,
		pos = {
			x = 0,
			y = 20
		},
		sound = g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_03
	}
}

return var_0_3
