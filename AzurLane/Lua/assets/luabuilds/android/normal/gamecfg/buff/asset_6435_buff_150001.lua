return {
	time = 20,
	name = "",
	init_effect = "",
	picture = "",
	desc = "",
	stack = 1,
	id = 150001,
	icon = 150000,
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
				effect = "bulunnusi_hudun_01",
				count = 7,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							3,
							5,
							8
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
					math = var_1_10003

					local var_1_1 = var_1_10003.sin(var_1_0) * 4
					local var_1_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_1_1, var_1_2, var_1_10005.cos(var_1_0) * 4)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					local var_2_0 = 0

					ys = var_1_10003

					return var_1_10001(var_2_0, arg_2_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				effect = "bulunnusi_hudun_01",
				count = 7,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							3,
							5,
							8
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

					local var_3_1 = var_3_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

					Vector3 = var_2
					math = var_1_10003

					local var_3_2 = var_1_10003.sin(var_3_1) * 4
					local var_3_3 = 0.75

					math = var_1_10005

					return var_2(var_3_2, var_3_3, var_1_10005.cos(var_3_1) * 4)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10003

					return var_1_10001(var_4_0, arg_4_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
				effect = "bulunnusi_hudun_01",
				count = 7,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							3,
							5,
							8
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

					ys = var_1_10002

					local var_5_1 = var_5_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

					Vector3 = var_2
					math = var_1_10003

					local var_5_2 = var_1_10003.sin(var_5_1) * 4
					local var_5_3 = 0.75

					math = var_1_10005

					return var_2(var_5_2, var_5_3, var_1_10005.cos(var_5_1) * 4)
				end,
				rotationFun = function(arg_6_0)
					Vector3 = var_1_10001

					local var_6_0 = 0

					ys = var_1_10003

					return var_1_10001(var_6_0, arg_6_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 30, 0)
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
				effect = "bulunnusi_hudun_01",
				count = 7,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							3,
							5,
							8
						},
						offset = {
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_7_0)
					local var_7_0 = arg_7_0 * 3 + 1.0466666666666666

					Vector3 = var_1_10002
					math = var_1_10003

					local var_7_1 = var_1_10003.sin(var_7_0) * 4
					local var_7_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_7_1, var_7_2, var_1_10005.cos(var_7_0) * 4)
				end,
				rotationFun = function(arg_8_0)
					Vector3 = var_1_10001

					local var_8_0 = 0

					ys = var_1_10003

					return var_1_10001(var_8_0, arg_8_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 22, 0)
				end
			}
		},
		{
			id = 5,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "bulunnusi_hudun_01",
				count = 7,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							3,
							5,
							8
						},
						offset = {
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_9_0)
					local var_9_0 = arg_9_0 * 3 + 3.14

					Vector3 = var_1_10002
					math = var_1_10003

					local var_9_1 = var_1_10003.sin(var_9_0) * 4
					local var_9_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_9_1, var_9_2, var_1_10005.cos(var_9_0) * 4)
				end,
				rotationFun = function(arg_10_0)
					Vector3 = var_1_10001

					local var_10_0 = 0

					ys = var_1_10003

					return var_1_10001(var_10_0, arg_10_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
				end
			}
		},
		{
			id = 6,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "bulunnusi_hudun_01",
				count = 7,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							3,
							5,
							8
						},
						offset = {
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_11_0)
					local var_11_0 = arg_11_0 * 3 + 5.233333333333333

					Vector3 = var_1_10002
					math = var_1_10003

					local var_11_1 = var_1_10003.sin(var_11_0) * 4
					local var_11_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_11_1, var_11_2, var_1_10005.cos(var_11_0) * 4)
				end,
				rotationFun = function(arg_12_0)
					Vector3 = var_1_10001

					local var_12_0 = 0

					ys = var_1_10003

					return var_1_10001(var_12_0, arg_12_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 22, 0)
				end
			}
		}
	}
}
