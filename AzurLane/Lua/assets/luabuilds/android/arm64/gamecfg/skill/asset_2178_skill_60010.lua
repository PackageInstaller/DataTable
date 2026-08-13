return {
	uiEffect = "",
	name = "大黄蜂-轰炸",
	cd = 0,
	picture = "0",
	aniEffect = "",
	desc = "轰炸",
	painting = 1,
	id = 60010,
	effect_list = {
		{
			targetAniEffect = "",
			type = "BattleSkillFire",
			target_choise = "TargetHarmRandom",
			arg_list = {
				weapon_id = 61001,
				delay = 4
			},
			casterAniEffect = {
				time = 1,
				effect = "feijiyingzi",
				posFun = function(arg_1_0, arg_1_1, arg_1_2)
					Vector3 = var_1_10003

					return var_1_10003(-100, 0, arg_1_1.z) - arg_1_0
				end
			}
		},
		{
			targetAniEffect = "",
			casterAniEffect = "",
			type = "BattleSkillFire",
			target_choise = "TargetSameToLastEffect",
			arg_list = {
				weapon_id = 61002,
				delay = 4
			}
		}
	}
}
