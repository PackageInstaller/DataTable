local var_0_0 = {
	desc_get = "",
	name = "Lucky A",
	init_effect = "",
	id = 12435,
	time = 0,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 12430,
	last_effect = ""
}
local var_0_1 = {}

SYSTEM_SCENARIO = var_0_10002
var_0_1[1] = var_0_10002
SYSTEM_ROUTINE = var_0_10002
var_0_1[2] = var_0_10002
SYSTEM_SHAM = var_0_10002
var_0_1[3] = var_0_10002
SYSTEM_CHALLENGE = var_0_10002
var_0_1[4] = var_0_10002
SYSTEM_ACT_BOSS = var_0_10002
var_0_1[5] = var_0_10002
var_0_0.limit = var_0_1
var_0_0.effect_list = {
	{
		type = "BattleBuffCastSkill",
		trigger = {
			"onStartGame"
		},
		arg_list = {
			skill_id = 12430,
			target = "TargetSelf"
		}
	},
	{
		type = "BattleBuffAddBuff",
		trigger = {
			"onUpdate"
		},
		arg_list = {
			buff_id = 12436,
			time = 20,
			target = "TargetSelf"
		}
	}
}
var_0_0[1] = {}
var_0_0[2] = {}
var_0_0[3] = {}
var_0_0[4] = {}
var_0_0[5] = {}
var_0_0[6] = {}
var_0_0[7] = {}
var_0_0[8] = {}
var_0_0[9] = {}
var_0_0[10] = {}

return var_0_0
