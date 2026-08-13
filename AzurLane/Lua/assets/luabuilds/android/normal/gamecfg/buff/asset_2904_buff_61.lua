local var_0_0 = {
	time = 0,
	name = "驱逐竞技场加成",
	init_effect = "",
	picture = "",
	desc = "额外提升闪避5%",
	stack = 1,
	id = 61,
	icon = 61,
	last_effect = ""
}
local var_0_1 = {}

SYSTEM_SCENARIO = var_0_10002
var_0_1[1] = var_0_10002
SYSTEM_ROUTINE = var_0_10002
var_0_1[2] = var_0_10002
var_0_0.limit = var_0_1
var_0_0.effect_list = {
	{
		type = "BattleBuffAddAttr",
		trigger = {
			"onAttach"
		},
		arg_list = {
			number = 0.05,
			attr = "dodgeRateExtra"
		}
	},
	{
		type = "BattleBuffAddAttr",
		trigger = {
			"onAttach"
		},
		arg_list = {
			number = -0.25,
			attr = "injureRatio"
		}
	}
}

return var_0_0
