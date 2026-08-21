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
				effect = "shield02",
				count = 70,
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
				count = 70,
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
				count = 70,
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
				count = 70,
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
				count = 70,
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
			type = "BattleBuffCastSkill",
			trigger = {
				"onShieldBroken"
			},
			arg_list = {
				skill_id = 600102,
				shieldBuffID = 600104
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
					effect = "shield02",
					count = 30,
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
						return Vector3(math.sin(arg_11_0 * 3) * 3, 0.75, math.cos(arg_11_0 * 3) * 3)
					end,
					rotationFun = function(arg_12_0)
						return Vector3(0, arg_12_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					count = 30,
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
						return Vector3(math.sin(arg_13_0 * 3 + 1.256) * 3, 0.75, math.cos(arg_13_0 * 3 + 1.256) * 3)
					end,
					rotationFun = function(arg_14_0)
						return Vector3(0, arg_14_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 162, 0)
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
					count = 30,
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
						return Vector3(math.sin(arg_15_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_15_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_16_0)
						return Vector3(0, arg_16_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					count = 30,
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
					centerPosFun = function(arg_17_0)
						return Vector3(math.sin(arg_17_0 * 3 - 1.256) * 3, 0.75, math.cos(arg_17_0 * 3 - 1.256) * 3)
					end,
					rotationFun = function(arg_18_0)
						return Vector3(0, arg_18_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 18, 0)
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
					count = 30,
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
					centerPosFun = function(arg_19_0)
						return Vector3(math.sin(arg_19_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_19_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_20_0)
						return Vector3(0, arg_20_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 600102,
					shieldBuffID = 600104
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
					effect = "shield02",
					count = 50,
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
					centerPosFun = function(arg_21_0)
						return Vector3(math.sin(arg_21_0 * 3) * 3, 0.75, math.cos(arg_21_0 * 3) * 3)
					end,
					rotationFun = function(arg_22_0)
						return Vector3(0, arg_22_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					count = 50,
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
					centerPosFun = function(arg_23_0)
						return Vector3(math.sin(arg_23_0 * 3 + 1.256) * 3, 0.75, math.cos(arg_23_0 * 3 + 1.256) * 3)
					end,
					rotationFun = function(arg_24_0)
						return Vector3(0, arg_24_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 162, 0)
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
					count = 50,
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
					centerPosFun = function(arg_25_0)
						return Vector3(math.sin(arg_25_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_25_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_26_0)
						return Vector3(0, arg_26_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					count = 50,
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
					centerPosFun = function(arg_27_0)
						return Vector3(math.sin(arg_27_0 * 3 - 1.256) * 3, 0.75, math.cos(arg_27_0 * 3 - 1.256) * 3)
					end,
					rotationFun = function(arg_28_0)
						return Vector3(0, arg_28_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 18, 0)
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
					count = 50,
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
					centerPosFun = function(arg_29_0)
						return Vector3(math.sin(arg_29_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_29_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_30_0)
						return Vector3(0, arg_30_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 600102,
					shieldBuffID = 600104
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
					effect = "shield02",
					count = 70,
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
					centerPosFun = function(arg_31_0)
						return Vector3(math.sin(arg_31_0 * 3) * 3, 0.75, math.cos(arg_31_0 * 3) * 3)
					end,
					rotationFun = function(arg_32_0)
						return Vector3(0, arg_32_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					count = 70,
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
					centerPosFun = function(arg_33_0)
						return Vector3(math.sin(arg_33_0 * 3 + 1.256) * 3, 0.75, math.cos(arg_33_0 * 3 + 1.256) * 3)
					end,
					rotationFun = function(arg_34_0)
						return Vector3(0, arg_34_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 162, 0)
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
					count = 70,
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
					centerPosFun = function(arg_35_0)
						return Vector3(math.sin(arg_35_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_35_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_36_0)
						return Vector3(0, arg_36_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					count = 70,
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
					centerPosFun = function(arg_37_0)
						return Vector3(math.sin(arg_37_0 * 3 - 1.256) * 3, 0.75, math.cos(arg_37_0 * 3 - 1.256) * 3)
					end,
					rotationFun = function(arg_38_0)
						return Vector3(0, arg_38_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 18, 0)
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
					count = 70,
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
					centerPosFun = function(arg_39_0)
						return Vector3(math.sin(arg_39_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_39_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_40_0)
						return Vector3(0, arg_40_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 600102,
					shieldBuffID = 600104
				}
			}
		}
	},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	init_effect = "",
	name = "",
	time = 0,
	picture = "",
	desc = "",
	stack = 1,
	id = 600104,
	last_effect = ""
}
