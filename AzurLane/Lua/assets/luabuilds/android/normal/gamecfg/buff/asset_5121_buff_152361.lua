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
				centerPosFun = function(arg_7_0)
					local var_7_0 = arg_7_0 * 3

					Vector3 = var_1_10002
					math = var_1_10003

					local var_7_1 = var_1_10003.sin(var_7_0) * 8
					local var_7_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_7_1, var_7_2, var_1_10005.cos(var_7_0) * 8)
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
				centerPosFun = function(arg_9_0)
					local var_9_0 = arg_9_0 * 3

					ys = var_1_10002

					local var_9_1 = var_9_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

					Vector3 = var_2
					math = var_1_10003

					local var_9_2 = var_1_10003.sin(var_9_1) * 8
					local var_9_3 = 0.75

					math = var_1_10005

					return var_2(var_9_2, var_9_3, var_1_10005.cos(var_9_1) * 8)
				end,
				rotationFun = function(arg_10_0)
					Vector3 = var_1_10001

					local var_10_0 = 0

					ys = var_1_10003

					return var_1_10001(var_10_0, arg_10_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
				end
			}
		},
		{
			id = 6,
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
				centerPosFun = function(arg_11_0)
					local var_11_0 = arg_11_0 * 3

					ys = var_1_10002

					local var_11_1 = var_11_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

					Vector3 = var_2
					math = var_1_10003

					local var_11_2 = var_1_10003.sin(var_11_1) * 8
					local var_11_3 = 0.75

					math = var_1_10005

					return var_2(var_11_2, var_11_3, var_1_10005.cos(var_11_1) * 8)
				end,
				rotationFun = function(arg_12_0)
					Vector3 = var_1_10001

					local var_12_0 = 0

					ys = var_1_10003

					return var_1_10001(var_12_0, arg_12_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
				end
			}
		}
	},
	{
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
					centerPosFun = function(arg_13_0)
						local var_13_0 = arg_13_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_13_1 = var_1_10003.sin(var_13_0) * 3
						local var_13_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_13_1, var_13_2, var_1_10005.cos(var_13_0) * 3)
					end,
					rotationFun = function(arg_14_0)
						Vector3 = var_1_10001

						local var_14_0 = 0

						ys = var_1_10003

						return var_1_10001(var_14_0, arg_14_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_15_0)
						local var_15_0 = arg_15_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_15_1 = var_1_10003.sin(var_15_0) * 3
						local var_15_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_15_1, var_15_2, var_1_10005.cos(var_15_0) * 3)
					end,
					rotationFun = function(arg_16_0)
						Vector3 = var_1_10001

						local var_16_0 = 0

						ys = var_1_10003

						return var_1_10001(var_16_0, arg_16_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_17_0)
						local var_17_0 = arg_17_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_17_1 = var_1_10003.sin(var_17_0) * 3
						local var_17_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_17_1, var_17_2, var_1_10005.cos(var_17_0) * 3)
					end,
					rotationFun = function(arg_18_0)
						Vector3 = var_1_10001

						local var_18_0 = 0

						ys = var_1_10003

						return var_1_10001(var_18_0, arg_18_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
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

						Vector3 = var_1_10002
						math = var_1_10003

						local var_19_1 = var_1_10003.sin(var_19_0) * 8
						local var_19_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_19_1, var_19_2, var_1_10005.cos(var_19_0) * 8)
					end,
					rotationFun = function(arg_20_0)
						Vector3 = var_1_10001

						local var_20_0 = 0

						ys = var_1_10003

						return var_1_10001(var_20_0, arg_20_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
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

						local var_21_1 = var_21_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

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

						return var_1_10001(var_22_0, arg_22_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
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
					centerPosFun = function(arg_23_0)
						local var_23_0 = arg_23_0 * 3

						ys = var_1_10002

						local var_23_1 = var_23_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_23_2 = var_1_10003.sin(var_23_1) * 8
						local var_23_3 = 0.75

						math = var_1_10005

						return var_2(var_23_2, var_23_3, var_1_10005.cos(var_23_1) * 8)
					end,
					rotationFun = function(arg_24_0)
						Vector3 = var_1_10001

						local var_24_0 = 0

						ys = var_1_10003

						return var_1_10001(var_24_0, arg_24_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_25_0)
						local var_25_0 = arg_25_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_25_1 = var_1_10003.sin(var_25_0) * 3
						local var_25_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_25_1, var_25_2, var_1_10005.cos(var_25_0) * 3)
					end,
					rotationFun = function(arg_26_0)
						Vector3 = var_1_10001

						local var_26_0 = 0

						ys = var_1_10003

						return var_1_10001(var_26_0, arg_26_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_27_0)
						local var_27_0 = arg_27_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_27_1 = var_1_10003.sin(var_27_0) * 3
						local var_27_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_27_1, var_27_2, var_1_10005.cos(var_27_0) * 3)
					end,
					rotationFun = function(arg_28_0)
						Vector3 = var_1_10001

						local var_28_0 = 0

						ys = var_1_10003

						return var_1_10001(var_28_0, arg_28_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_29_0)
						local var_29_0 = arg_29_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_29_1 = var_1_10003.sin(var_29_0) * 3
						local var_29_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_29_1, var_29_2, var_1_10005.cos(var_29_0) * 3)
					end,
					rotationFun = function(arg_30_0)
						Vector3 = var_1_10001

						local var_30_0 = 0

						ys = var_1_10003

						return var_1_10001(var_30_0, arg_30_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 60,
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
					centerPosFun = function(arg_31_0)
						local var_31_0 = arg_31_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_31_1 = var_1_10003.sin(var_31_0) * 8
						local var_31_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_31_1, var_31_2, var_1_10005.cos(var_31_0) * 8)
					end,
					rotationFun = function(arg_32_0)
						Vector3 = var_1_10001

						local var_32_0 = 0

						ys = var_1_10003

						return var_1_10001(var_32_0, arg_32_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 60,
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
					centerPosFun = function(arg_33_0)
						local var_33_0 = arg_33_0 * 3

						ys = var_1_10002

						local var_33_1 = var_33_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_33_2 = var_1_10003.sin(var_33_1) * 8
						local var_33_3 = 0.75

						math = var_1_10005

						return var_2(var_33_2, var_33_3, var_1_10005.cos(var_33_1) * 8)
					end,
					rotationFun = function(arg_34_0)
						Vector3 = var_1_10001

						local var_34_0 = 0

						ys = var_1_10003

						return var_1_10001(var_34_0, arg_34_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 60,
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
					centerPosFun = function(arg_35_0)
						local var_35_0 = arg_35_0 * 3

						ys = var_1_10002

						local var_35_1 = var_35_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_35_2 = var_1_10003.sin(var_35_1) * 8
						local var_35_3 = 0.75

						math = var_1_10005

						return var_2(var_35_2, var_35_3, var_1_10005.cos(var_35_1) * 8)
					end,
					rotationFun = function(arg_36_0)
						Vector3 = var_1_10001

						local var_36_0 = 0

						ys = var_1_10003

						return var_1_10001(var_36_0, arg_36_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_37_0)
						local var_37_0 = arg_37_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_37_1 = var_1_10003.sin(var_37_0) * 3
						local var_37_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_37_1, var_37_2, var_1_10005.cos(var_37_0) * 3)
					end,
					rotationFun = function(arg_38_0)
						Vector3 = var_1_10001

						local var_38_0 = 0

						ys = var_1_10003

						return var_1_10001(var_38_0, arg_38_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_39_0)
						local var_39_0 = arg_39_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_39_1 = var_1_10003.sin(var_39_0) * 3
						local var_39_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_39_1, var_39_2, var_1_10005.cos(var_39_0) * 3)
					end,
					rotationFun = function(arg_40_0)
						Vector3 = var_1_10001

						local var_40_0 = 0

						ys = var_1_10003

						return var_1_10001(var_40_0, arg_40_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_41_0)
						local var_41_0 = arg_41_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_41_1 = var_1_10003.sin(var_41_0) * 3
						local var_41_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_41_1, var_41_2, var_1_10005.cos(var_41_0) * 3)
					end,
					rotationFun = function(arg_42_0)
						Vector3 = var_1_10001

						local var_42_0 = 0

						ys = var_1_10003

						return var_1_10001(var_42_0, arg_42_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 65,
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
					centerPosFun = function(arg_43_0)
						local var_43_0 = arg_43_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_43_1 = var_1_10003.sin(var_43_0) * 8
						local var_43_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_43_1, var_43_2, var_1_10005.cos(var_43_0) * 8)
					end,
					rotationFun = function(arg_44_0)
						Vector3 = var_1_10001

						local var_44_0 = 0

						ys = var_1_10003

						return var_1_10001(var_44_0, arg_44_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 65,
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
					centerPosFun = function(arg_45_0)
						local var_45_0 = arg_45_0 * 3

						ys = var_1_10002

						local var_45_1 = var_45_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_45_2 = var_1_10003.sin(var_45_1) * 8
						local var_45_3 = 0.75

						math = var_1_10005

						return var_2(var_45_2, var_45_3, var_1_10005.cos(var_45_1) * 8)
					end,
					rotationFun = function(arg_46_0)
						Vector3 = var_1_10001

						local var_46_0 = 0

						ys = var_1_10003

						return var_1_10001(var_46_0, arg_46_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 65,
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
					centerPosFun = function(arg_47_0)
						local var_47_0 = arg_47_0 * 3

						ys = var_1_10002

						local var_47_1 = var_47_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_47_2 = var_1_10003.sin(var_47_1) * 8
						local var_47_3 = 0.75

						math = var_1_10005

						return var_2(var_47_2, var_47_3, var_1_10005.cos(var_47_1) * 8)
					end,
					rotationFun = function(arg_48_0)
						Vector3 = var_1_10001

						local var_48_0 = 0

						ys = var_1_10003

						return var_1_10001(var_48_0, arg_48_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_49_0)
						local var_49_0 = arg_49_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_49_1 = var_1_10003.sin(var_49_0) * 3
						local var_49_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_49_1, var_49_2, var_1_10005.cos(var_49_0) * 3)
					end,
					rotationFun = function(arg_50_0)
						Vector3 = var_1_10001

						local var_50_0 = 0

						ys = var_1_10003

						return var_1_10001(var_50_0, arg_50_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_51_0)
						local var_51_0 = arg_51_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_51_1 = var_1_10003.sin(var_51_0) * 3
						local var_51_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_51_1, var_51_2, var_1_10005.cos(var_51_0) * 3)
					end,
					rotationFun = function(arg_52_0)
						Vector3 = var_1_10001

						local var_52_0 = 0

						ys = var_1_10003

						return var_1_10001(var_52_0, arg_52_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_53_0)
						local var_53_0 = arg_53_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_53_1 = var_1_10003.sin(var_53_0) * 3
						local var_53_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_53_1, var_53_2, var_1_10005.cos(var_53_0) * 3)
					end,
					rotationFun = function(arg_54_0)
						Vector3 = var_1_10001

						local var_54_0 = 0

						ys = var_1_10003

						return var_1_10001(var_54_0, arg_54_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 70,
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
					centerPosFun = function(arg_55_0)
						local var_55_0 = arg_55_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_55_1 = var_1_10003.sin(var_55_0) * 8
						local var_55_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_55_1, var_55_2, var_1_10005.cos(var_55_0) * 8)
					end,
					rotationFun = function(arg_56_0)
						Vector3 = var_1_10001

						local var_56_0 = 0

						ys = var_1_10003

						return var_1_10001(var_56_0, arg_56_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 70,
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
					centerPosFun = function(arg_57_0)
						local var_57_0 = arg_57_0 * 3

						ys = var_1_10002

						local var_57_1 = var_57_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_57_2 = var_1_10003.sin(var_57_1) * 8
						local var_57_3 = 0.75

						math = var_1_10005

						return var_2(var_57_2, var_57_3, var_1_10005.cos(var_57_1) * 8)
					end,
					rotationFun = function(arg_58_0)
						Vector3 = var_1_10001

						local var_58_0 = 0

						ys = var_1_10003

						return var_1_10001(var_58_0, arg_58_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 70,
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
					centerPosFun = function(arg_59_0)
						local var_59_0 = arg_59_0 * 3

						ys = var_1_10002

						local var_59_1 = var_59_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_59_2 = var_1_10003.sin(var_59_1) * 8
						local var_59_3 = 0.75

						math = var_1_10005

						return var_2(var_59_2, var_59_3, var_1_10005.cos(var_59_1) * 8)
					end,
					rotationFun = function(arg_60_0)
						Vector3 = var_1_10001

						local var_60_0 = 0

						ys = var_1_10003

						return var_1_10001(var_60_0, arg_60_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_61_0)
						local var_61_0 = arg_61_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_61_1 = var_1_10003.sin(var_61_0) * 3
						local var_61_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_61_1, var_61_2, var_1_10005.cos(var_61_0) * 3)
					end,
					rotationFun = function(arg_62_0)
						Vector3 = var_1_10001

						local var_62_0 = 0

						ys = var_1_10003

						return var_1_10001(var_62_0, arg_62_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_63_0)
						local var_63_0 = arg_63_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_63_1 = var_1_10003.sin(var_63_0) * 3
						local var_63_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_63_1, var_63_2, var_1_10005.cos(var_63_0) * 3)
					end,
					rotationFun = function(arg_64_0)
						Vector3 = var_1_10001

						local var_64_0 = 0

						ys = var_1_10003

						return var_1_10001(var_64_0, arg_64_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_65_0)
						local var_65_0 = arg_65_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_65_1 = var_1_10003.sin(var_65_0) * 3
						local var_65_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_65_1, var_65_2, var_1_10005.cos(var_65_0) * 3)
					end,
					rotationFun = function(arg_66_0)
						Vector3 = var_1_10001

						local var_66_0 = 0

						ys = var_1_10003

						return var_1_10001(var_66_0, arg_66_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 75,
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
					centerPosFun = function(arg_67_0)
						local var_67_0 = arg_67_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_67_1 = var_1_10003.sin(var_67_0) * 8
						local var_67_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_67_1, var_67_2, var_1_10005.cos(var_67_0) * 8)
					end,
					rotationFun = function(arg_68_0)
						Vector3 = var_1_10001

						local var_68_0 = 0

						ys = var_1_10003

						return var_1_10001(var_68_0, arg_68_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 75,
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
					centerPosFun = function(arg_69_0)
						local var_69_0 = arg_69_0 * 3

						ys = var_1_10002

						local var_69_1 = var_69_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_69_2 = var_1_10003.sin(var_69_1) * 8
						local var_69_3 = 0.75

						math = var_1_10005

						return var_2(var_69_2, var_69_3, var_1_10005.cos(var_69_1) * 8)
					end,
					rotationFun = function(arg_70_0)
						Vector3 = var_1_10001

						local var_70_0 = 0

						ys = var_1_10003

						return var_1_10001(var_70_0, arg_70_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 75,
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
					centerPosFun = function(arg_71_0)
						local var_71_0 = arg_71_0 * 3

						ys = var_1_10002

						local var_71_1 = var_71_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_71_2 = var_1_10003.sin(var_71_1) * 8
						local var_71_3 = 0.75

						math = var_1_10005

						return var_2(var_71_2, var_71_3, var_1_10005.cos(var_71_1) * 8)
					end,
					rotationFun = function(arg_72_0)
						Vector3 = var_1_10001

						local var_72_0 = 0

						ys = var_1_10003

						return var_1_10001(var_72_0, arg_72_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_73_0)
						local var_73_0 = arg_73_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_73_1 = var_1_10003.sin(var_73_0) * 3
						local var_73_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_73_1, var_73_2, var_1_10005.cos(var_73_0) * 3)
					end,
					rotationFun = function(arg_74_0)
						Vector3 = var_1_10001

						local var_74_0 = 0

						ys = var_1_10003

						return var_1_10001(var_74_0, arg_74_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_75_0)
						local var_75_0 = arg_75_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_75_1 = var_1_10003.sin(var_75_0) * 3
						local var_75_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_75_1, var_75_2, var_1_10005.cos(var_75_0) * 3)
					end,
					rotationFun = function(arg_76_0)
						Vector3 = var_1_10001

						local var_76_0 = 0

						ys = var_1_10003

						return var_1_10001(var_76_0, arg_76_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_77_0)
						local var_77_0 = arg_77_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_77_1 = var_1_10003.sin(var_77_0) * 3
						local var_77_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_77_1, var_77_2, var_1_10005.cos(var_77_0) * 3)
					end,
					rotationFun = function(arg_78_0)
						Vector3 = var_1_10001

						local var_78_0 = 0

						ys = var_1_10003

						return var_1_10001(var_78_0, arg_78_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 80,
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
					centerPosFun = function(arg_79_0)
						local var_79_0 = arg_79_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_79_1 = var_1_10003.sin(var_79_0) * 8
						local var_79_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_79_1, var_79_2, var_1_10005.cos(var_79_0) * 8)
					end,
					rotationFun = function(arg_80_0)
						Vector3 = var_1_10001

						local var_80_0 = 0

						ys = var_1_10003

						return var_1_10001(var_80_0, arg_80_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 80,
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
					centerPosFun = function(arg_81_0)
						local var_81_0 = arg_81_0 * 3

						ys = var_1_10002

						local var_81_1 = var_81_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_81_2 = var_1_10003.sin(var_81_1) * 8
						local var_81_3 = 0.75

						math = var_1_10005

						return var_2(var_81_2, var_81_3, var_1_10005.cos(var_81_1) * 8)
					end,
					rotationFun = function(arg_82_0)
						Vector3 = var_1_10001

						local var_82_0 = 0

						ys = var_1_10003

						return var_1_10001(var_82_0, arg_82_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 80,
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
					centerPosFun = function(arg_83_0)
						local var_83_0 = arg_83_0 * 3

						ys = var_1_10002

						local var_83_1 = var_83_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_83_2 = var_1_10003.sin(var_83_1) * 8
						local var_83_3 = 0.75

						math = var_1_10005

						return var_2(var_83_2, var_83_3, var_1_10005.cos(var_83_1) * 8)
					end,
					rotationFun = function(arg_84_0)
						Vector3 = var_1_10001

						local var_84_0 = 0

						ys = var_1_10003

						return var_1_10001(var_84_0, arg_84_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_85_0)
						local var_85_0 = arg_85_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_85_1 = var_1_10003.sin(var_85_0) * 3
						local var_85_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_85_1, var_85_2, var_1_10005.cos(var_85_0) * 3)
					end,
					rotationFun = function(arg_86_0)
						Vector3 = var_1_10001

						local var_86_0 = 0

						ys = var_1_10003

						return var_1_10001(var_86_0, arg_86_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_87_0)
						local var_87_0 = arg_87_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_87_1 = var_1_10003.sin(var_87_0) * 3
						local var_87_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_87_1, var_87_2, var_1_10005.cos(var_87_0) * 3)
					end,
					rotationFun = function(arg_88_0)
						Vector3 = var_1_10001

						local var_88_0 = 0

						ys = var_1_10003

						return var_1_10001(var_88_0, arg_88_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_89_0)
						local var_89_0 = arg_89_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_89_1 = var_1_10003.sin(var_89_0) * 3
						local var_89_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_89_1, var_89_2, var_1_10005.cos(var_89_0) * 3)
					end,
					rotationFun = function(arg_90_0)
						Vector3 = var_1_10001

						local var_90_0 = 0

						ys = var_1_10003

						return var_1_10001(var_90_0, arg_90_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 85,
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
					centerPosFun = function(arg_91_0)
						local var_91_0 = arg_91_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_91_1 = var_1_10003.sin(var_91_0) * 8
						local var_91_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_91_1, var_91_2, var_1_10005.cos(var_91_0) * 8)
					end,
					rotationFun = function(arg_92_0)
						Vector3 = var_1_10001

						local var_92_0 = 0

						ys = var_1_10003

						return var_1_10001(var_92_0, arg_92_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 85,
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
					centerPosFun = function(arg_93_0)
						local var_93_0 = arg_93_0 * 3

						ys = var_1_10002

						local var_93_1 = var_93_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_93_2 = var_1_10003.sin(var_93_1) * 8
						local var_93_3 = 0.75

						math = var_1_10005

						return var_2(var_93_2, var_93_3, var_1_10005.cos(var_93_1) * 8)
					end,
					rotationFun = function(arg_94_0)
						Vector3 = var_1_10001

						local var_94_0 = 0

						ys = var_1_10003

						return var_1_10001(var_94_0, arg_94_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 85,
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
					centerPosFun = function(arg_95_0)
						local var_95_0 = arg_95_0 * 3

						ys = var_1_10002

						local var_95_1 = var_95_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_95_2 = var_1_10003.sin(var_95_1) * 8
						local var_95_3 = 0.75

						math = var_1_10005

						return var_2(var_95_2, var_95_3, var_1_10005.cos(var_95_1) * 8)
					end,
					rotationFun = function(arg_96_0)
						Vector3 = var_1_10001

						local var_96_0 = 0

						ys = var_1_10003

						return var_1_10001(var_96_0, arg_96_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_97_0)
						local var_97_0 = arg_97_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_97_1 = var_1_10003.sin(var_97_0) * 3
						local var_97_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_97_1, var_97_2, var_1_10005.cos(var_97_0) * 3)
					end,
					rotationFun = function(arg_98_0)
						Vector3 = var_1_10001

						local var_98_0 = 0

						ys = var_1_10003

						return var_1_10001(var_98_0, arg_98_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_99_0)
						local var_99_0 = arg_99_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_99_1 = var_1_10003.sin(var_99_0) * 3
						local var_99_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_99_1, var_99_2, var_1_10005.cos(var_99_0) * 3)
					end,
					rotationFun = function(arg_100_0)
						Vector3 = var_1_10001

						local var_100_0 = 0

						ys = var_1_10003

						return var_1_10001(var_100_0, arg_100_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_101_0)
						local var_101_0 = arg_101_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_101_1 = var_1_10003.sin(var_101_0) * 3
						local var_101_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_101_1, var_101_2, var_1_10005.cos(var_101_0) * 3)
					end,
					rotationFun = function(arg_102_0)
						Vector3 = var_1_10001

						local var_102_0 = 0

						ys = var_1_10003

						return var_1_10001(var_102_0, arg_102_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 90,
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
					centerPosFun = function(arg_103_0)
						local var_103_0 = arg_103_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_103_1 = var_1_10003.sin(var_103_0) * 8
						local var_103_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_103_1, var_103_2, var_1_10005.cos(var_103_0) * 8)
					end,
					rotationFun = function(arg_104_0)
						Vector3 = var_1_10001

						local var_104_0 = 0

						ys = var_1_10003

						return var_1_10001(var_104_0, arg_104_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 90,
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
					centerPosFun = function(arg_105_0)
						local var_105_0 = arg_105_0 * 3

						ys = var_1_10002

						local var_105_1 = var_105_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_105_2 = var_1_10003.sin(var_105_1) * 8
						local var_105_3 = 0.75

						math = var_1_10005

						return var_2(var_105_2, var_105_3, var_1_10005.cos(var_105_1) * 8)
					end,
					rotationFun = function(arg_106_0)
						Vector3 = var_1_10001

						local var_106_0 = 0

						ys = var_1_10003

						return var_1_10001(var_106_0, arg_106_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 90,
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
					centerPosFun = function(arg_107_0)
						local var_107_0 = arg_107_0 * 3

						ys = var_1_10002

						local var_107_1 = var_107_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_107_2 = var_1_10003.sin(var_107_1) * 8
						local var_107_3 = 0.75

						math = var_1_10005

						return var_2(var_107_2, var_107_3, var_1_10005.cos(var_107_1) * 8)
					end,
					rotationFun = function(arg_108_0)
						Vector3 = var_1_10001

						local var_108_0 = 0

						ys = var_1_10003

						return var_1_10001(var_108_0, arg_108_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_109_0)
						local var_109_0 = arg_109_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_109_1 = var_1_10003.sin(var_109_0) * 3
						local var_109_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_109_1, var_109_2, var_1_10005.cos(var_109_0) * 3)
					end,
					rotationFun = function(arg_110_0)
						Vector3 = var_1_10001

						local var_110_0 = 0

						ys = var_1_10003

						return var_1_10001(var_110_0, arg_110_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_111_0)
						local var_111_0 = arg_111_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_111_1 = var_1_10003.sin(var_111_0) * 3
						local var_111_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_111_1, var_111_2, var_1_10005.cos(var_111_0) * 3)
					end,
					rotationFun = function(arg_112_0)
						Vector3 = var_1_10001

						local var_112_0 = 0

						ys = var_1_10003

						return var_1_10001(var_112_0, arg_112_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_113_0)
						local var_113_0 = arg_113_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_113_1 = var_1_10003.sin(var_113_0) * 3
						local var_113_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_113_1, var_113_2, var_1_10005.cos(var_113_0) * 3)
					end,
					rotationFun = function(arg_114_0)
						Vector3 = var_1_10001

						local var_114_0 = 0

						ys = var_1_10003

						return var_1_10001(var_114_0, arg_114_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 95,
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
					centerPosFun = function(arg_115_0)
						local var_115_0 = arg_115_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_115_1 = var_1_10003.sin(var_115_0) * 8
						local var_115_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_115_1, var_115_2, var_1_10005.cos(var_115_0) * 8)
					end,
					rotationFun = function(arg_116_0)
						Vector3 = var_1_10001

						local var_116_0 = 0

						ys = var_1_10003

						return var_1_10001(var_116_0, arg_116_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 95,
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
					centerPosFun = function(arg_117_0)
						local var_117_0 = arg_117_0 * 3

						ys = var_1_10002

						local var_117_1 = var_117_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_117_2 = var_1_10003.sin(var_117_1) * 8
						local var_117_3 = 0.75

						math = var_1_10005

						return var_2(var_117_2, var_117_3, var_1_10005.cos(var_117_1) * 8)
					end,
					rotationFun = function(arg_118_0)
						Vector3 = var_1_10001

						local var_118_0 = 0

						ys = var_1_10003

						return var_1_10001(var_118_0, arg_118_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 95,
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
					centerPosFun = function(arg_119_0)
						local var_119_0 = arg_119_0 * 3

						ys = var_1_10002

						local var_119_1 = var_119_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_119_2 = var_1_10003.sin(var_119_1) * 8
						local var_119_3 = 0.75

						math = var_1_10005

						return var_2(var_119_2, var_119_3, var_1_10005.cos(var_119_1) * 8)
					end,
					rotationFun = function(arg_120_0)
						Vector3 = var_1_10001

						local var_120_0 = 0

						ys = var_1_10003

						return var_1_10001(var_120_0, arg_120_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	{
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
					centerPosFun = function(arg_121_0)
						local var_121_0 = arg_121_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_121_1 = var_1_10003.sin(var_121_0) * 3
						local var_121_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_121_1, var_121_2, var_1_10005.cos(var_121_0) * 3)
					end,
					rotationFun = function(arg_122_0)
						Vector3 = var_1_10001

						local var_122_0 = 0

						ys = var_1_10003

						return var_1_10001(var_122_0, arg_122_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					centerPosFun = function(arg_123_0)
						local var_123_0 = arg_123_0 * 3 + 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_123_1 = var_1_10003.sin(var_123_0) * 3
						local var_123_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_123_1, var_123_2, var_1_10005.cos(var_123_0) * 3)
					end,
					rotationFun = function(arg_124_0)
						Vector3 = var_1_10001

						local var_124_0 = 0

						ys = var_1_10003

						return var_1_10001(var_124_0, arg_124_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					centerPosFun = function(arg_125_0)
						local var_125_0 = arg_125_0 * 3 - 2.512

						Vector3 = var_1_10002
						math = var_1_10003

						local var_125_1 = var_1_10003.sin(var_125_0) * 3
						local var_125_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_125_1, var_125_2, var_1_10005.cos(var_125_0) * 3)
					end,
					rotationFun = function(arg_126_0)
						Vector3 = var_1_10001

						local var_126_0 = 0

						ys = var_1_10003

						return var_1_10001(var_126_0, arg_126_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				id = 4,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 100,
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
					centerPosFun = function(arg_127_0)
						local var_127_0 = arg_127_0 * 3

						Vector3 = var_1_10002
						math = var_1_10003

						local var_127_1 = var_1_10003.sin(var_127_0) * 8
						local var_127_2 = 0.75

						math = var_1_10005

						return var_1_10002(var_127_1, var_127_2, var_1_10005.cos(var_127_0) * 8)
					end,
					rotationFun = function(arg_128_0)
						Vector3 = var_1_10001

						local var_128_0 = 0

						ys = var_1_10003

						return var_1_10001(var_128_0, arg_128_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
					end
				}
			},
			{
				id = 5,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 100,
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
					centerPosFun = function(arg_129_0)
						local var_129_0 = arg_129_0 * 3

						ys = var_1_10002

						local var_129_1 = var_129_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_2

						Vector3 = var_2
						math = var_1_10003

						local var_129_2 = var_1_10003.sin(var_129_1) * 8
						local var_129_3 = 0.75

						math = var_1_10005

						return var_2(var_129_2, var_129_3, var_1_10005.cos(var_129_1) * 8)
					end,
					rotationFun = function(arg_130_0)
						Vector3 = var_1_10001

						local var_130_0 = 0

						ys = var_1_10003

						return var_1_10001(var_130_0, arg_130_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
					end
				}
			},
			{
				id = 6,
				type = "BattleBuffDamageWall",
				trigger = {
					"onStack",
					"onUpdate"
				},
				arg_list = {
					damage = 100,
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
					centerPosFun = function(arg_131_0)
						local var_131_0 = arg_131_0 * 3

						ys = var_1_10002

						local var_131_1 = var_131_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST_4

						Vector3 = var_2
						math = var_1_10003

						local var_131_2 = var_1_10003.sin(var_131_1) * 8
						local var_131_3 = 0.75

						math = var_1_10005

						return var_2(var_131_2, var_131_3, var_1_10005.cos(var_131_1) * 8)
					end,
					rotationFun = function(arg_132_0)
						Vector3 = var_1_10001

						local var_132_0 = 0

						ys = var_1_10003

						return var_1_10001(var_132_0, arg_132_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
					end
				}
			}
		}
	},
	time = 10,
	name = "",
	init_effect = "",
	picture = "",
	desc = "守卫之盾",
	stack = 1,
	id = 152361,
	icon = 152361,
	last_effect = ""
}
