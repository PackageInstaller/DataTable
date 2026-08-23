local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local BattleAttr = require("battle.const.BattleAttr")
local var_0_3 = {
	ROOM_MAX_NUM = 5,
	ABLE_FRAGMENT_TYPE = 138,
	FORMAT_SUCCUBA_NUM_MAX = 3,
	STAR_MAX = 7,
	DEV_TYPE = {
		INFO = 1,
		ADV_UP = 4,
		STAR_UP = 3,
		LV_UP = 2
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
		INTERACTION_EXP_ID = 2,
		CHAT_AI_EXP_TIMES = 1,
		FORMATION_MAX_ID = 6,
		AUTO_INTERACTION_TIME_ID = 5,
		INTERACTION_TIMES_ID = 4,
		FIRST_INTERACTION_DEFAULT_QUALITY_ID = 3
	},
	AI_KEY = {}
}

var_0_3.DEV_ARR = {
	[var_0_3.DEV_TYPE.INFO] = {
		comp = "succuba/SuccubaInfoComp",
		selectIcon = "ui://base_new/icon_yht_xinxi_1",
		normalIcon = "ui://base_new/icon_yht_xinxi_2",
		resInfoId = 357,
		title = g.core.lang:get(431005),
		cond = function()
			return var_0_0:getUnlockComment(var_0_1.SUCCUBA)
		end,
		show = function()
			return var_0_0:isModuleShow(var_0_1.SUCCUBA)
		end,
		index = var_0_3.DEV_TYPE.INFO,
		pos = {
			y = 10,
			x = 0
		},
		sound = g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_03
	},
	[var_0_3.DEV_TYPE.LV_UP] = {
		comp = "succuba/SuccubaLvUpComp",
		newRedPointId = 894,
		selectIcon = "ui://succuba/icon_mnzj_yc_tiaoli1",
		normalIcon = "ui://succuba/icon_mnzj_yc_tiaoli2",
		resInfoId = 358,
		title = g.core.lang:get(431006),
		cond = function()
			return var_0_0:getUnlockComment(var_0_1.SUCCUBA)
		end,
		show = function()
			return var_0_0:isModuleShow(var_0_1.SUCCUBA)
		end,
		index = var_0_3.DEV_TYPE.LV_UP,
		pos = {
			y = 20,
			x = 0
		},
		sound = g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_03
	},
	[var_0_3.DEV_TYPE.STAR_UP] = {
		comp = "succuba/SuccubaStarUpComp",
		newRedPointId = 895,
		selectIcon = "ui://base_new/icon_yht_shengxing_1",
		normalIcon = "ui://base_new/icon_yht_shengxing_2",
		resInfoId = 359,
		title = g.core.lang:get(431007),
		cond = function()
			return var_0_0:getUnlockComment(var_0_1.SUCCUBA)
		end,
		show = function()
			return var_0_0:isModuleShow(var_0_1.SUCCUBA)
		end,
		index = var_0_3.DEV_TYPE.STAR_UP,
		pos = {
			y = 20,
			x = 0
		},
		sound = g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_03
	},
	[var_0_3.DEV_TYPE.ADV_UP] = {
		comp = "succuba/SuccubaAdvUpComp",
		newRedPointId = 919,
		selectIcon = "ui://succuba/icon_mnzj_yc_zhiyv1",
		normalIcon = "ui://succuba/icon_mnzj_yc_zhiyv2",
		resInfoId = 366,
		title = g.core.lang:get(431047),
		cond = function()
			return var_0_0:getUnlockComment(var_0_1.SUCCUBA)
		end,
		show = function()
			return var_0_0:isModuleShow(var_0_1.SUCCUBA)
		end,
		index = var_0_3.DEV_TYPE.ADV_UP,
		pos = {
			y = 20,
			x = 0
		},
		sound = g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_03
	}
}

return var_0_3
