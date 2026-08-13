return {
	init_effect = "",
	name = "2020偶像二期EX 对雷暴AT立场",
	time = 0,
	picture = "",
	desc = "",
	stack = 1,
	id = 8748,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddAttr",
			trigger = {
				"onAttach"
			},
			arg_list = {
				number = -0.8,
				attr = "injureRatioByBulletTorpedo"
			}
		},
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield05",
				count = 6,
				do_when_hit = "intercept",
				bulletType = 3,
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
					math = var_1_10003

					local var_1_1 = var_1_10003.sin(var_1_0) * 2
					local var_1_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_1_1, var_1_2, var_1_10005.cos(var_1_0) * 2)
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
				effect = "shield05",
				count = 6,
				do_when_hit = "intercept",
				bulletType = 3,
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
					local var_3_0 = arg_3_0 * 3 + 1.256

					Vector3 = var_1_10002
					math = var_1_10003

					local var_3_1 = var_1_10003.sin(var_3_0) * 2
					local var_3_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_3_1, var_3_2, var_1_10005.cos(var_3_0) * 2)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10003

					return var_1_10001(var_4_0, arg_4_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 162, 0)
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
				effect = "shield05",
				count = 6,
				do_when_hit = "intercept",
				bulletType = 3,
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
					local var_5_0 = arg_5_0 * 3 + 2.512

					Vector3 = var_1_10002
					math = var_1_10003

					local var_5_1 = var_1_10003.sin(var_5_0) * 2
					local var_5_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_5_1, var_5_2, var_1_10005.cos(var_5_0) * 2)
				end,
				rotationFun = function(arg_6_0)
					Vector3 = var_1_10001

					local var_6_0 = 0

					ys = var_1_10003

					return var_1_10001(var_6_0, arg_6_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
				effect = "shield05",
				count = 6,
				do_when_hit = "intercept",
				bulletType = 3,
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
					local var_7_0 = arg_7_0 * 3 - 1.256

					Vector3 = var_1_10002
					math = var_1_10003

					local var_7_1 = var_1_10003.sin(var_7_0) * 2
					local var_7_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_7_1, var_7_2, var_1_10005.cos(var_7_0) * 2)
				end,
				rotationFun = function(arg_8_0)
					Vector3 = var_1_10001

					local var_8_0 = 0

					ys = var_1_10003

					return var_1_10001(var_8_0, arg_8_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 18, 0)
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
				effect = "shield05",
				count = 6,
				do_when_hit = "intercept",
				bulletType = 3,
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
				centerPosFun = function(arg_9_0)
					local var_9_0 = arg_9_0 * 3 - 2.512

					Vector3 = var_1_10002
					math = var_1_10003

					local var_9_1 = var_1_10003.sin(var_9_0) * 2
					local var_9_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_9_1, var_9_2, var_1_10005.cos(var_9_0) * 2)
				end,
				rotationFun = function(arg_10_0)
					Vector3 = var_1_10001

					local var_10_0 = 0

					ys = var_1_10003

					return var_1_10001(var_10_0, arg_10_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
				end
			}
		}
	}
}
