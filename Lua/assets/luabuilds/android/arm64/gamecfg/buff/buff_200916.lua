return {
	time = 0,
	name = "2024偶像活动三期EX 欧根盾（地狱）",
	init_effect = "",
	id = 200916,
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
				count = 99999,
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
					return Vector3(math.sin(arg_1_0 * 3) * 3, 0.75, math.cos(arg_1_0 * 3) * 3)
				end,
				rotationFun = function(arg_2_0)
					return Vector3(0, arg_2_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_3_0 * 3 + 1.256) * 3, 0.75, math.cos(arg_3_0 * 3 + 1.256) * 3)
				end,
				rotationFun = function(arg_4_0)
					return Vector3(0, arg_4_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 162, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_5_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_5_0 * 3 + 2.512) * 3)
				end,
				rotationFun = function(arg_6_0)
					return Vector3(0, arg_6_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_7_0 * 3 - 1.256) * 3, 0.75, math.cos(arg_7_0 * 3 - 1.256) * 3)
				end,
				rotationFun = function(arg_8_0)
					return Vector3(0, arg_8_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 18, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_9_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_9_0 * 3 - 2.512) * 3)
				end,
				rotationFun = function(arg_10_0)
					return Vector3(0, arg_10_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_11_0 * -2.4) * 5, 0.75, math.cos(arg_11_0 * -2.4) * 5)
				end,
				rotationFun = function(arg_12_0)
					return Vector3(0, arg_12_0 * -0.8 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_13_0 * -2.4 + 0.785) * 5, 0.75, math.cos(arg_13_0 * -2.4 + 0.785) * 5)
				end,
				rotationFun = function(arg_14_0)
					return Vector3(0, arg_14_0 * -0.8 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 7, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_15_0 * -2.4 + 1.57) * 5, 0.75, math.cos(arg_15_0 * -2.4 + 1.57) * 5)
				end,
				rotationFun = function(arg_16_0)
					return Vector3(0, arg_16_0 * -0.8 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 180, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_17_0 * -2.4 + 2.355) * 5, 0.75, math.cos(arg_17_0 * -2.4 + 2.355) * 5)
				end,
				rotationFun = function(arg_18_0)
					return Vector3(0, arg_18_0 * -0.8 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 225, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_19_0 * -2.4 + 3.14) * 5, 0.75, math.cos(arg_19_0 * -2.4 + 3.14) * 5)
				end,
				rotationFun = function(arg_20_0)
					return Vector3(0, arg_20_0 * -0.8 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 14, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_21_0 * -2.4 + 3.9250000000000003) * 5, 0.75, math.cos(arg_21_0 * -2.4 + 3.9250000000000003) * 5)
				end,
				rotationFun = function(arg_22_0)
					return Vector3(0, arg_22_0 * -0.8 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 315, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_23_0 * -2.4 + 4.71) * 5, 0.75, math.cos(arg_23_0 * -2.4 + 4.71) * 5)
				end,
				rotationFun = function(arg_24_0)
					return Vector3(0, arg_24_0 * -0.8 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST, 0)
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
				count = 99999,
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
					return Vector3(math.sin(arg_25_0 * -2.4 + 5.495) * 5, 0.75, math.cos(arg_25_0 * -2.4 + 5.495) * 5)
				end,
				rotationFun = function(arg_26_0)
					return Vector3(0, arg_26_0 * -0.8 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 45, 0)
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
				damage = 100,
				effect = "shield06",
				count = 99999,
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
					return Vector3(math.sin(arg_27_0 * 1.5) * 8, 0.75, math.cos(arg_27_0 * 1.5) * 8)
				end,
				rotationFun = function(arg_28_0)
					return Vector3(0, arg_28_0 * 0.5 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				damage = 100,
				effect = "shield06",
				count = 99999,
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
					return Vector3(math.sin(arg_29_0 * 1.5 + 1.0466666666666666) * 8, 0.75, math.cos(arg_29_0 * 1.5 + 1.0466666666666666) * 8)
				end,
				rotationFun = function(arg_30_0)
					return Vector3(0, arg_30_0 * 0.5 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 22, 0)
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
				damage = 100,
				effect = "shield06",
				count = 99999,
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
					return Vector3(math.sin(arg_31_0 * 1.5 + 2.0933333333333333) * 8, 0.75, math.cos(arg_31_0 * 1.5 + 2.0933333333333333) * 8)
				end,
				rotationFun = function(arg_32_0)
					return Vector3(0, arg_32_0 * 0.5 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
				damage = 100,
				effect = "shield06",
				count = 99999,
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
					return Vector3(math.sin(arg_33_0 * 1.5 + 3.14) * 8, 0.75, math.cos(arg_33_0 * 1.5 + 3.14) * 8)
				end,
				rotationFun = function(arg_34_0)
					return Vector3(0, arg_34_0 * 0.5 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 14, 0)
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
				damage = 100,
				effect = "shield06",
				count = 99999,
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
					return Vector3(math.sin(arg_35_0 * 1.5 + 4.1866666666666665) * 8, 0.75, math.cos(arg_35_0 * 1.5 + 4.1866666666666665) * 8)
				end,
				rotationFun = function(arg_36_0)
					return Vector3(0, arg_36_0 * 0.5 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 330, 0)
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
				damage = 100,
				effect = "shield06",
				count = 99999,
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
					return Vector3(math.sin(arg_37_0 * 1.5 + 5.233333333333333) * 8, 0.75, math.cos(arg_37_0 * 1.5 + 5.233333333333333) * 8)
				end,
				rotationFun = function(arg_38_0)
					return Vector3(0, arg_38_0 * 0.5 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 30, 0)
				end
			}
		}
	}
}
