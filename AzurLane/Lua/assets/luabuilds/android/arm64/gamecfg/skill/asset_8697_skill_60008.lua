return {
	uiEffect = "AimEffectUI",
	name = "海伦娜-舰队之眼",
	cd = 0,
	picture = "0",
	aniEffect = "",
	desc = "舰队之眼",
	painting = 1,
	id = 60008,
	effect_list = {
		{
			target_choise = "TargetHarmRandom",
			type = "BattleSkillAddBuff",
			arg_list = {
				buff_id = 60015
			},
			targetAniEffect = {
				effect = "aim",
				posFun = function(arg_1_0, arg_1_1, arg_1_2)
					math = var_1_10003
					arg_1_2 = var_1_10003.min(1, arg_1_2 / 40)

					local var_1_0 = (arg_1_0.x - arg_1_1.x) * (1 - arg_1_2)
					local var_1_1 = 1 * arg_1_2
					local var_1_2 = arg_1_0.z - arg_1_1.z + var_3 * (1 - arg_1_2) * arg_1_2

					if 1 <= arg_1_2 then
						var_1_2 = 0
					elseif 0.8 <= arg_1_2 then
						var_1_2 = var_1_2 * (-4 * arg_1_2 + 4)
					elseif 0.5 <= arg_1_2 then
						var_1_2 = var_1_2 * arg_1_2
					else
						var_1_2 = var_1_2 * (1 - arg_1_2)
					end

					Vector3 = var_7

					return var_7(var_1_0, var_1_1, var_1_2)
				end
			}
		}
	}
}
