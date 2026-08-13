return {
	effect_list = {
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield05",
				count = 2,
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

					local var_1_1 = var_1_10003.sin(var_1_0) * 3
					local var_1_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_1_1, var_1_2, var_1_10005.cos(var_1_0) * 3)
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
				count = 2,
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
					local var_3_0 = arg_3_0 * 3 + 2.512

					Vector3 = var_1_10002
					math = var_1_10003

					local var_3_1 = var_1_10003.sin(var_3_0) * 3
					local var_3_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_3_1, var_3_2, var_1_10005.cos(var_3_0) * 3)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10003

					return var_1_10001(var_4_0, arg_4_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
				count = 2,
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
					local var_5_0 = arg_5_0 * 3 - 2.512

					Vector3 = var_1_10002
					math = var_1_10003

					local var_5_1 = var_1_10003.sin(var_5_0) * 3
					local var_5_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_5_1, var_5_2, var_1_10005.cos(var_5_0) * 3)
				end,
				rotationFun = function(arg_6_0)
					Vector3 = var_1_10001

					local var_6_0 = 0

					ys = var_1_10003

					return var_1_10001(var_6_0, arg_6_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
				count = 4,
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

					Vector3 = var_1_10002
					math = var_1_10003

					local var_7_1 = var_1_10003.sin(var_7_0) * 5
					local var_7_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_7_1, var_7_2, var_1_10005.cos(var_7_0) * 5)
				end,
				rotationFun = function(arg_8_0)
					Vector3 = var_1_10001

					local var_8_0 = 0

					ys = var_1_10003

					return var_1_10001(var_8_0, arg_8_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				effect = "shield02",
				count = 4,
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
				centerPosFun = function(arg_9_0)
					local var_9_0 = arg_9_0 * 3 + 1.256

					Vector3 = var_1_10002
					math = var_1_10003

					local var_9_1 = var_1_10003.sin(var_9_0) * 5
					local var_9_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_9_1, var_9_2, var_1_10005.cos(var_9_0) * 5)
				end,
				rotationFun = function(arg_10_0)
					Vector3 = var_1_10001

					local var_10_0 = 0

					ys = var_1_10003

					return var_1_10001(var_10_0, arg_10_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 162, 0)
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
				effect = "shield02",
				count = 4,
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
				centerPosFun = function(arg_11_0)
					local var_11_0 = arg_11_0 * 3 + 2.512

					Vector3 = var_1_10002
					math = var_1_10003

					local var_11_1 = var_1_10003.sin(var_11_0) * 5
					local var_11_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_11_1, var_11_2, var_1_10005.cos(var_11_0) * 5)
				end,
				rotationFun = function(arg_12_0)
					Vector3 = var_1_10001

					local var_12_0 = 0

					ys = var_1_10003

					return var_1_10001(var_12_0, arg_12_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
				end
			}
		},
		{
			id = 7,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 4,
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
				centerPosFun = function(arg_13_0)
					local var_13_0 = arg_13_0 * 3 - 1.256

					Vector3 = var_1_10002
					math = var_1_10003

					local var_13_1 = var_1_10003.sin(var_13_0) * 5
					local var_13_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_13_1, var_13_2, var_1_10005.cos(var_13_0) * 5)
				end,
				rotationFun = function(arg_14_0)
					Vector3 = var_1_10001

					local var_14_0 = 0

					ys = var_1_10003

					return var_1_10001(var_14_0, arg_14_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 18, 0)
				end
			}
		},
		{
			id = 8,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 4,
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
				centerPosFun = function(arg_15_0)
					local var_15_0 = arg_15_0 * 3 - 2.512

					Vector3 = var_1_10002
					math = var_1_10003

					local var_15_1 = var_1_10003.sin(var_15_0) * 5
					local var_15_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_15_1, var_15_2, var_1_10005.cos(var_15_0) * 5)
				end,
				rotationFun = function(arg_16_0)
					Vector3 = var_1_10001

					local var_16_0 = 0

					ys = var_1_10003

					return var_1_10001(var_16_0, arg_16_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
				end
			}
		},
		{
			id = 9,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 55,
				effect = "shield06",
				count = 6,
				attack_attribute = 1,
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
				centerPosFun = function(arg_17_0)
					local var_17_0 = arg_17_0 * 3

					Vector3 = var_1_10002
					math = var_1_10003

					local var_17_1 = var_1_10003.sin(var_17_0) * 8
					local var_17_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_17_1, var_17_2, var_1_10005.cos(var_17_0) * 8)
				end,
				rotationFun = function(arg_18_0)
					Vector3 = var_1_10001

					local var_18_0 = 0

					ys = var_1_10003

					return var_1_10001(var_18_0, arg_18_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
				end
			}
		},
		{
			id = 10,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 55,
				effect = "shield06",
				count = 6,
				attack_attribute = 1,
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
				centerPosFun = function(arg_19_0)
					local var_19_0 = arg_19_0 * 3

					ys = var_1_10002

					local var_19_1 = var_19_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

					Vector3 = var_2
					math = var_1_10003

					local var_19_2 = var_1_10003.sin(var_19_1) * 8
					local var_19_3 = 0.75

					math = var_1_10005

					return var_2(var_19_2, var_19_3, var_1_10005.cos(var_19_1) * 8)
				end,
				rotationFun = function(arg_20_0)
					Vector3 = var_1_10001

					local var_20_0 = 0

					ys = var_1_10003

					return var_1_10001(var_20_0, arg_20_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
				end
			}
		},
		{
			id = 11,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 55,
				effect = "shield06",
				count = 6,
				attack_attribute = 1,
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
				centerPosFun = function(arg_21_0)
					local var_21_0 = arg_21_0 * 3

					ys = var_1_10002

					local var_21_1 = var_21_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

					Vector3 = var_2
					math = var_1_10003

					local var_21_2 = var_1_10003.sin(var_21_1) * 8
					local var_21_3 = 0.75

					math = var_1_10005

					return var_2(var_21_2, var_21_3, var_1_10005.cos(var_21_1) * 8)
				end,
				rotationFun = function(arg_22_0)
					Vector3 = var_1_10001

					local var_22_0 = 0

					ys = var_1_10003

					return var_1_10001(var_22_0, arg_22_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
				end
			}
		}
	},
	{
		time = 5
	},
	{
		time = 5.5
	},
	{
		time = 6
	},
	{
		time = 6.5
	},
	{
		time = 7
	},
	{
		time = 7.5
	},
	{
		time = 8
	},
	{
		time = 8.5
	},
	{
		time = 9
	},
	{
		time = 10
	},
	init_effect = "",
	name = "",
	time = 1,
	picture = "",
	desc = "",
	stack = 1,
	id = 15541,
	last_effect = ""
}
