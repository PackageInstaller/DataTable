local var_0_0 = {
	time = 0,
	name = "竞技场我方加成",
	init_effect = "",
	picture = "",
	desc = "减少20%受到伤害",
	stack = 1,
	id = 49,
	icon = 49,
	last_effect = ""
}
local var_0_1 = {}

SYSTEM_SCENARIO = var_0_10002
var_0_1[1] = var_0_10002
SYSTEM_ROUTINE = var_0_10002
var_0_1[2] = var_0_10002
SYSTEM_DUEL = var_0_10002
var_0_1[3] = var_0_10002
var_0_0.limit = var_0_1
var_0_0.effect_list = {
	{
		type = "BattleBuffAddAttr",
		trigger = {
			"onAttach"
		},
		arg_list = {
			number = -0.2,
			target = "TargetSelf",
			attr = "injureRatio"
		}
	},
	{
		type = "BattleBuffAddAttr",
		trigger = {
			"onAttach"
		},
		arg_list = {
			number = -0.2,
			target = "TargetSelf",
			attr = "injureRatioByAir"
		}
	}
}

return var_0_0
