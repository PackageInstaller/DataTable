local var_0_0 = {
	time = 0,
	name = "竞技场BUFF触发器",
	init_effect = "",
	picture = "",
	desc = "竞技场BUFF",
	stack = 1,
	id = 51,
	icon = 51,
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
		type = "BattleBuffCastSkill",
		trigger = {
			"onStartGame"
		},
		arg_list = {
			skill_id = 51
		}
	}
}

return var_0_0
