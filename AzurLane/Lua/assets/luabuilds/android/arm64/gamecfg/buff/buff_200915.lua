return {
	time = 0,
	name = "2024偶像活动三期EX 欧根盾（普通）",
	init_effect = "",
	id = 200915,
	picture = "",
	desc = "",
	stack = 1,
	color = "yellow",
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
				count = 60,
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

					local var_1_1 = var_1_10004.sin(var_1_0) * 3
					local var_1_2 = 0.75

					math = var_6

					return var_1_10002(var_1_1, var_1_2, var_6.cos(var_1_0) * 3)
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
				count = 60,
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
					local var_3_0 = arg_3_0 * 3 + 1.256

					Vector3 = var_1_10002
					math = var_1_10004

					local var_3_1 = var_1_10004.sin(var_3_0) * 3
					local var_3_2 = 0.75

					math = var_6

					return var_1_10002(var_3_1, var_3_2, var_6.cos(var_3_0) * 3)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10004

					return var_1_10001(var_4_0, arg_4_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST + 162, 0)
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
				count = 60,
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
					local var_5_0 = arg_5_0 * 3 + 2.512

					Vector3 = var_1_10002
					math = var_1_10004

					local var_5_1 = var_1_10004.sin(var_5_0) * 3
					local var_5_2 = 0.75

					math = var_6

					return var_1_10002(var_5_1, var_5_2, var_6.cos(var_5_0) * 3)
				end,
				rotationFun = function(arg_6_0)
					Vector3 = var_1_10001

					local var_6_0 = 0

					ys = var_1_10004

					return var_1_10001(var_6_0, arg_6_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
				count = 60,
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
					local var_7_0 = arg_7_0 * 3 - 1.256

					Vector3 = var_1_10002
					math = var_1_10004

					local var_7_1 = var_1_10004.sin(var_7_0) * 3
					local var_7_2 = 0.75

					math = var_6

					return var_1_10002(var_7_1, var_7_2, var_6.cos(var_7_0) * 3)
				end,
				rotationFun = function(arg_8_0)
					Vector3 = var_1_10001

					local var_8_0 = 0

					ys = var_1_10004

					return var_1_10001(var_8_0, arg_8_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST + 18, 0)
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
				count = 60,
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
					local var_9_0 = arg_9_0 * 3 - 2.512

					Vector3 = var_1_10002
					math = var_1_10004

					local var_9_1 = var_1_10004.sin(var_9_0) * 3
					local var_9_2 = 0.75

					math = var_6

					return var_1_10002(var_9_1, var_9_2, var_6.cos(var_9_0) * 3)
				end,
				rotationFun = function(arg_10_0)
					Vector3 = var_1_10001

					local var_10_0 = 0

					ys = var_1_10004

					return var_1_10001(var_10_0, arg_10_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
				effect = "shield05",
				count = 10,
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
				centerPosFun = function(arg_11_0)
					local var_11_0 = arg_11_0 * -2.4

					Vector3 = var_1_10002
					math = var_1_10004

					local var_11_1 = var_1_10004.sin(var_11_0) * 5
					local var_11_2 = 0.75

					math = var_6

					return var_1_10002(var_11_1, var_11_2, var_6.cos(var_11_0) * 5)
				end,
				rotationFun = function(arg_12_0)
					Vector3 = var_1_10001

					local var_12_0 = 0
					local var_12_1 = arg_12_0 * -0.8

					ys = var_1_10005

					return var_1_10001(var_12_0, var_12_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				effect = "shield05",
				count = 10,
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
				centerPosFun = function(arg_13_0)
					local var_13_0 = arg_13_0 * -2.4 + 0.785

					Vector3 = var_1_10002
					math = var_1_10004

					local var_13_1 = var_1_10004.sin(var_13_0) * 5
					local var_13_2 = 0.75

					math = var_6

					return var_1_10002(var_13_1, var_13_2, var_6.cos(var_13_0) * 5)
				end,
				rotationFun = function(arg_14_0)
					Vector3 = var_1_10001

					local var_14_0 = 0
					local var_14_1 = arg_14_0 * -0.8

					ys = var_1_10005

					return var_1_10001(var_14_0, var_14_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 7, 0)
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
				effect = "shield05",
				count = 10,
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
				centerPosFun = function(arg_15_0)
					local var_15_0 = arg_15_0 * -2.4 + 1.57

					Vector3 = var_1_10002
					math = var_1_10004

					local var_15_1 = var_1_10004.sin(var_15_0) * 5
					local var_15_2 = 0.75

					math = var_6

					return var_1_10002(var_15_1, var_15_2, var_6.cos(var_15_0) * 5)
				end,
				rotationFun = function(arg_16_0)
					Vector3 = var_1_10001

					local var_16_0 = 0
					local var_16_1 = arg_16_0 * -0.8

					ys = var_1_10005

					return var_1_10001(var_16_0, var_16_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 180, 0)
				end
			}
		},
		{
			id = 9,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield05",
				count = 10,
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
				centerPosFun = function(arg_17_0)
					local var_17_0 = arg_17_0 * -2.4 + 2.355

					Vector3 = var_1_10002
					math = var_1_10004

					local var_17_1 = var_1_10004.sin(var_17_0) * 5
					local var_17_2 = 0.75

					math = var_6

					return var_1_10002(var_17_1, var_17_2, var_6.cos(var_17_0) * 5)
				end,
				rotationFun = function(arg_18_0)
					Vector3 = var_1_10001

					local var_18_0 = 0
					local var_18_1 = arg_18_0 * -0.8

					ys = var_1_10005

					return var_1_10001(var_18_0, var_18_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 225, 0)
				end
			}
		},
		{
			id = 10,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield05",
				count = 10,
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
				centerPosFun = function(arg_19_0)
					local var_19_0 = arg_19_0 * -2.4 + 3.14

					Vector3 = var_1_10002
					math = var_1_10004

					local var_19_1 = var_1_10004.sin(var_19_0) * 5
					local var_19_2 = 0.75

					math = var_6

					return var_1_10002(var_19_1, var_19_2, var_6.cos(var_19_0) * 5)
				end,
				rotationFun = function(arg_20_0)
					Vector3 = var_1_10001

					local var_20_0 = 0
					local var_20_1 = arg_20_0 * -0.8

					ys = var_1_10005

					return var_1_10001(var_20_0, var_20_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 14, 0)
				end
			}
		},
		{
			id = 11,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield05",
				count = 10,
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
				centerPosFun = function(arg_21_0)
					local var_21_0 = arg_21_0 * -2.4 + 3.9250000000000003

					Vector3 = var_1_10002
					math = var_1_10004

					local var_21_1 = var_1_10004.sin(var_21_0) * 5
					local var_21_2 = 0.75

					math = var_6

					return var_1_10002(var_21_1, var_21_2, var_6.cos(var_21_0) * 5)
				end,
				rotationFun = function(arg_22_0)
					Vector3 = var_1_10001

					local var_22_0 = 0
					local var_22_1 = arg_22_0 * -0.8

					ys = var_1_10005

					return var_1_10001(var_22_0, var_22_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 315, 0)
				end
			}
		},
		{
			id = 12,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield05",
				count = 10,
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
				centerPosFun = function(arg_23_0)
					local var_23_0 = arg_23_0 * -2.4 + 4.71

					Vector3 = var_1_10002
					math = var_1_10004

					local var_23_1 = var_1_10004.sin(var_23_0) * 5
					local var_23_2 = 0.75

					math = var_6

					return var_1_10002(var_23_1, var_23_2, var_6.cos(var_23_0) * 5)
				end,
				rotationFun = function(arg_24_0)
					Vector3 = var_1_10001

					local var_24_0 = 0
					local var_24_1 = arg_24_0 * -0.8

					ys = var_1_10005

					return var_1_10001(var_24_0, var_24_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST, 0)
				end
			}
		},
		{
			id = 13,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield05",
				count = 10,
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
				centerPosFun = function(arg_25_0)
					local var_25_0 = arg_25_0 * -2.4 + 5.495

					Vector3 = var_1_10002
					math = var_1_10004

					local var_25_1 = var_1_10004.sin(var_25_0) * 5
					local var_25_2 = 0.75

					math = var_6

					return var_1_10002(var_25_1, var_25_2, var_6.cos(var_25_0) * 5)
				end,
				rotationFun = function(arg_26_0)
					Vector3 = var_1_10001

					local var_26_0 = 0
					local var_26_1 = arg_26_0 * -0.8

					ys = var_1_10005

					return var_1_10001(var_26_0, var_26_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 45, 0)
				end
			}
		},
		{
			id = 14,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 12,
				effect = "shield06",
				count = 10,
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
				centerPosFun = function(arg_27_0)
					local var_27_0 = arg_27_0 * 1.5

					Vector3 = var_1_10002
					math = var_1_10004

					local var_27_1 = var_1_10004.sin(var_27_0) * 8
					local var_27_2 = 0.75

					math = var_6

					return var_1_10002(var_27_1, var_27_2, var_6.cos(var_27_0) * 8)
				end,
				rotationFun = function(arg_28_0)
					Vector3 = var_1_10001

					local var_28_0 = 0
					local var_28_1 = arg_28_0 * 0.5

					ys = var_1_10005

					return var_1_10001(var_28_0, var_28_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
				end
			}
		},
		{
			id = 15,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 12,
				effect = "shield06",
				count = 10,
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
				centerPosFun = function(arg_29_0)
					local var_29_0 = arg_29_0 * 1.5 + 1.0466666666666666

					Vector3 = var_1_10002
					math = var_1_10004

					local var_29_1 = var_1_10004.sin(var_29_0) * 8
					local var_29_2 = 0.75

					math = var_6

					return var_1_10002(var_29_1, var_29_2, var_6.cos(var_29_0) * 8)
				end,
				rotationFun = function(arg_30_0)
					Vector3 = var_1_10001

					local var_30_0 = 0
					local var_30_1 = arg_30_0 * 0.5

					ys = var_1_10005

					return var_1_10001(var_30_0, var_30_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 22, 0)
				end
			}
		},
		{
			id = 16,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 12,
				effect = "shield06",
				count = 10,
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
				centerPosFun = function(arg_31_0)
					local var_31_0 = arg_31_0 * 1.5 + 2.0933333333333333

					Vector3 = var_1_10002
					math = var_1_10004

					local var_31_1 = var_1_10004.sin(var_31_0) * 8
					local var_31_2 = 0.75

					math = var_6

					return var_1_10002(var_31_1, var_31_2, var_6.cos(var_31_0) * 8)
				end,
				rotationFun = function(arg_32_0)
					Vector3 = var_1_10001

					local var_32_0 = 0
					local var_32_1 = arg_32_0 * 0.5

					ys = var_1_10005

					return var_1_10001(var_32_0, var_32_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
				end
			}
		},
		{
			id = 17,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 12,
				effect = "shield06",
				count = 10,
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
				centerPosFun = function(arg_33_0)
					local var_33_0 = arg_33_0 * 1.5 + 3.14

					Vector3 = var_1_10002
					math = var_1_10004

					local var_33_1 = var_1_10004.sin(var_33_0) * 8
					local var_33_2 = 0.75

					math = var_6

					return var_1_10002(var_33_1, var_33_2, var_6.cos(var_33_0) * 8)
				end,
				rotationFun = function(arg_34_0)
					Vector3 = var_1_10001

					local var_34_0 = 0
					local var_34_1 = arg_34_0 * 0.5

					ys = var_1_10005

					return var_1_10001(var_34_0, var_34_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 14, 0)
				end
			}
		},
		{
			id = 18,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 12,
				effect = "shield06",
				count = 10,
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
				centerPosFun = function(arg_35_0)
					local var_35_0 = arg_35_0 * 1.5 + 4.1866666666666665

					Vector3 = var_1_10002
					math = var_1_10004

					local var_35_1 = var_1_10004.sin(var_35_0) * 8
					local var_35_2 = 0.75

					math = var_6

					return var_1_10002(var_35_1, var_35_2, var_6.cos(var_35_0) * 8)
				end,
				rotationFun = function(arg_36_0)
					Vector3 = var_1_10001

					local var_36_0 = 0
					local var_36_1 = arg_36_0 * 0.5

					ys = var_1_10005

					return var_1_10001(var_36_0, var_36_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 330, 0)
				end
			}
		},
		{
			id = 19,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 12,
				effect = "shield06",
				count = 10,
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
				centerPosFun = function(arg_37_0)
					local var_37_0 = arg_37_0 * 1.5 + 5.233333333333333

					Vector3 = var_1_10002
					math = var_1_10004

					local var_37_1 = var_1_10004.sin(var_37_0) * 8
					local var_37_2 = 0.75

					math = var_6

					return var_1_10002(var_37_1, var_37_2, var_6.cos(var_37_0) * 8)
				end,
				rotationFun = function(arg_38_0)
					Vector3 = var_1_10001

					local var_38_0 = 0
					local var_38_1 = arg_38_0 * 0.5

					ys = var_1_10005

					return var_1_10001(var_38_0, var_38_1 * var_1_10005.Battle.BattleConfig.SHIELD_ROTATE_CONST + 30, 0)
				end
			}
		}
	}
}
