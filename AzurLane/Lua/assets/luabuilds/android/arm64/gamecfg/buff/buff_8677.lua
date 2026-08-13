return {
	time = 20,
	name = "构建者护盾",
	init_effect = "",
	picture = "",
	desc = "构建者护盾",
	stack = 1,
	id = 8677,
	icon = 18100,
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
				count = 15,
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
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_1_0)
					local var_1_0 = arg_1_0 * 3

					Vector3 = var_1_10002
					math = var_1_10004

					local var_1_1 = var_1_10004.sin(var_1_0) * 4
					local var_1_2 = -0.5

					math = var_6

					return var_1_10002(var_1_1, var_1_2, var_6.cos(var_1_0) * 4 + 5)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					local var_2_0 = 0

					ys = var_1_10004

					return var_1_10001(var_2_0, arg_2_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				count = 15,
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

					local var_3_2 = var_1_10004.sin(var_3_1) * 4
					local var_3_3 = -0.5

					math = var_6

					return var_2(var_3_2, var_3_3, var_6.cos(var_3_1) * 4 + 5)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10004

					return var_1_10001(var_4_0, arg_4_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST - 90, 0)
				end
			}
		},
		{
			id = 3,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 15,
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
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_5_0)
					local var_5_0 = arg_5_0 * 3

					Vector3 = var_1_10002
					math = var_1_10004

					local var_5_1 = var_1_10004.cos(var_5_0) * 6
					local var_5_2 = -0.5

					math = var_6

					return var_1_10002(var_5_1, var_5_2, var_6.sin(var_5_0) * 6 + 5)
				end,
				rotationFun = function(arg_6_0)
					Vector3 = var_1_10001

					local var_6_0 = 0
					local var_6_1 = -arg_6_0

					ys = var_1_10005

					return var_1_10001(var_6_0, var_6_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 180, 0)
				end
			}
		},
		{
			id = 4,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 15,
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
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_7_0)
					local var_7_0 = arg_7_0 * 3

					ys = var_1_10002

					local var_7_1 = var_7_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST

					Vector3 = var_2
					math = var_1_10004

					local var_7_2 = var_1_10004.cos(var_7_1) * 6
					local var_7_3 = -0.5

					math = var_6

					return var_2(var_7_2, var_7_3, var_6.sin(var_7_1) * 6 + 5)
				end,
				rotationFun = function(arg_8_0)
					Vector3 = var_1_10001

					local var_8_0 = 0
					local var_8_1 = -arg_8_0

					ys = var_1_10005

					return var_1_10001(var_8_0, var_8_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 0, 0)
				end
			}
		}
	}
}
