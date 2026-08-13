return {
	time = 0,
	name = "勇者标枪永久盾牌",
	init_effect = "",
	id = 200101,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 200101,
	last_effect = "",
	effect_list = {
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield_yongzhe",
				count = 99999,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							5,
							12,
							15
						},
						offset = {
							1.5,
							0,
							1
						}
					}
				},
				centerPosFun = function(arg_1_0)
					Vector3 = var_1_10001

					return var_1_10001(3.5, -0.5, 0)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					return var_1_10001(0, 0, 0)
				end
			}
		}
	}
}
