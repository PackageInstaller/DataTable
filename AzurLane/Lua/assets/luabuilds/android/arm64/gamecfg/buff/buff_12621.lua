return {
	time = 12,
	name = "盾牌",
	init_effect = "",
	picture = "",
	desc = "盾牌",
	stack = 1,
	id = 12621,
	icon = 12620,
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
				effect = "shield02",
				count = 10,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							4,
							6,
							9
						},
						offset = {
							0,
							0,
							0
						}
					}
				},
				centerPosFun = function(arg_1_0)
					Vector3 = var_1_10001

					return var_1_10001(2.5, -1.8, 0.5)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					return var_1_10001(0, 192, 0)
				end
			}
		},
		{
			id = 2,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 10,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							5,
							7,
							10
						},
						offset = {
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_3_0)
					local var_3_0 = arg_3_0 * 3

					ys = var_1_10002

					local var_3_1 = var_3_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST

					Vector3 = var_2
					math = var_1_10004

					local var_3_2 = var_1_10004.sin(var_3_1) * 5
					local var_3_3 = -1.5

					math = var_6

					return var_2(var_3_2, var_3_3, var_6.cos(var_3_1) * 3.5)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10004

					return var_1_10001(var_4_0, arg_4_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST - 90, 0)
				end
			}
		}
	}
}
