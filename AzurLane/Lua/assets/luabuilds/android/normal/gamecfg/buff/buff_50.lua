local var_0_0 = {
	time = 0,
	name = "挑战后排永久无敌",
	init_effect = "",
	picture = "",
	desc = "挑战后排永久无敌",
	stack = 1,
	id = 50,
	icon = 50,
	last_effect = ""
}
local var_0_1 = {}

SYSTEM_SCENARIO = var_0_10002
var_0_1[1] = var_0_10002
SYSTEM_ROUTINE = var_0_10002
var_0_1[2] = var_0_10002
SYSTEM_DUEL = var_0_10002
var_0_1[3] = var_0_10002
SYSTEM_SHAM = var_0_10002
var_0_1[4] = var_0_10002
var_0_0.limit = var_0_1
var_0_0.effect_list = {
	{
		type = "BattleBuffAddAttr",
		trigger = {
			"onAttach",
			"onRemove"
		},
		arg_list = {
			group = 50,
			number = 1,
			attr = "isInvincible"
		}
	}
}

return var_0_0
