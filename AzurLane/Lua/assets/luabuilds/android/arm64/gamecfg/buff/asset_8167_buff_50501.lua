local var_0_0 = {
	time = 2,
	name = "敌方BOSS 对全航母后排额外攻击",
	init_effect = "",
	id = 50501,
	picture = "",
	desc = "",
	stack = 1,
	color = "yellow",
	icon = 50500,
	last_effect = ""
}
local var_0_1 = {}
local var_0_2 = {
	type = "BattleBuffCastSkill",
	trigger = {
		"onAttach"
	}
}
local var_0_3 = {
	skill_id = 50500,
	maxTargetNumber = 0,
	cloak = 0,
	check_target = {
		"TargetAllHarm",
		"TargetShipType",
		"TargetCloakState"
	}
}

ShipType = var_4
var_0_3.ship_type_list = var_4.MainShipType
var_0_2.arg_list = var_0_3
var_0_1[1] = var_0_2
var_0_0.effect_list = var_0_1

return var_0_0
