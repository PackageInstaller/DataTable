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
				posFun = function(self, arg_1_1, arg_1_2)
					arg_1_2 = math.min(1, arg_1_2 / 40)

					local var_1_0 = self.z - arg_1_1.z + (self.x - arg_1_1.x) * (1 - arg_1_2) * arg_1_2

					var_1_0 = arg_1_2 >= 1 and 0 or arg_1_2 >= 0.8 and var_1_0 * (-4 * arg_1_2 + 4) or arg_1_2 >= 0.5 and var_1_0 * arg_1_2 or var_1_0 * (1 - arg_1_2)

					return Vector3((self.x - arg_1_1.x) * (1 - arg_1_2), 1 * arg_1_2, var_1_0)
				end
			}
		}
	}
}
