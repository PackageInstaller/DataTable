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
					return Vector3(math.sin(arg_3_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_3_0 * 3 + 2.512) * 3)
				end,
				rotationFun = function(arg_4_0)
					return Vector3(0, arg_4_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
					return Vector3(math.sin(arg_5_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_5_0 * 3 - 2.512) * 3)
				end,
				rotationFun = function(arg_6_0)
					return Vector3(0, arg_6_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
					return Vector3(math.sin(arg_7_0 * 3) * 8, 0.75, math.cos(arg_7_0 * 3) * 8)
				end,
				rotationFun = function(arg_8_0)
					return Vector3(0, arg_8_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
					return Vector3(math.sin(arg_9_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_9_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
				end,
				rotationFun = function(arg_10_0)
					return Vector3(0, arg_10_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
					return Vector3(math.sin(arg_11_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_11_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
				end,
				rotationFun = function(arg_12_0)
					return Vector3(0, arg_12_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_13_0 * 3) * 3, 0.75, math.cos(arg_13_0 * 3) * 3)
					end,
					rotationFun = function(arg_14_0)
						return Vector3(0, arg_14_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_15_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_15_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_16_0)
						return Vector3(0, arg_16_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_17_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_17_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_18_0)
						return Vector3(0, arg_18_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_19_0 * 3) * 8, 0.75, math.cos(arg_19_0 * 3) * 8)
					end,
					rotationFun = function(arg_20_0)
						return Vector3(0, arg_20_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_21_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_21_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_22_0)
						return Vector3(0, arg_22_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_23_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_23_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_24_0)
						return Vector3(0, arg_24_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_25_0 * 3) * 3, 0.75, math.cos(arg_25_0 * 3) * 3)
					end,
					rotationFun = function(arg_26_0)
						return Vector3(0, arg_26_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_27_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_27_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_28_0)
						return Vector3(0, arg_28_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_29_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_29_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_30_0)
						return Vector3(0, arg_30_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_31_0 * 3) * 8, 0.75, math.cos(arg_31_0 * 3) * 8)
					end,
					rotationFun = function(arg_32_0)
						return Vector3(0, arg_32_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_33_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_33_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_34_0)
						return Vector3(0, arg_34_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_35_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_35_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_36_0)
						return Vector3(0, arg_36_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_37_0 * 3) * 3, 0.75, math.cos(arg_37_0 * 3) * 3)
					end,
					rotationFun = function(arg_38_0)
						return Vector3(0, arg_38_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_39_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_39_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_40_0)
						return Vector3(0, arg_40_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_41_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_41_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_42_0)
						return Vector3(0, arg_42_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_43_0 * 3) * 8, 0.75, math.cos(arg_43_0 * 3) * 8)
					end,
					rotationFun = function(arg_44_0)
						return Vector3(0, arg_44_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_45_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_45_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_46_0)
						return Vector3(0, arg_46_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_47_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_47_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_48_0)
						return Vector3(0, arg_48_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_49_0 * 3) * 3, 0.75, math.cos(arg_49_0 * 3) * 3)
					end,
					rotationFun = function(arg_50_0)
						return Vector3(0, arg_50_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_51_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_51_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_52_0)
						return Vector3(0, arg_52_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_53_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_53_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_54_0)
						return Vector3(0, arg_54_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_55_0 * 3) * 8, 0.75, math.cos(arg_55_0 * 3) * 8)
					end,
					rotationFun = function(arg_56_0)
						return Vector3(0, arg_56_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_57_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_57_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_58_0)
						return Vector3(0, arg_58_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_59_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_59_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_60_0)
						return Vector3(0, arg_60_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_61_0 * 3) * 3, 0.75, math.cos(arg_61_0 * 3) * 3)
					end,
					rotationFun = function(arg_62_0)
						return Vector3(0, arg_62_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_63_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_63_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_64_0)
						return Vector3(0, arg_64_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_65_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_65_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_66_0)
						return Vector3(0, arg_66_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_67_0 * 3) * 8, 0.75, math.cos(arg_67_0 * 3) * 8)
					end,
					rotationFun = function(arg_68_0)
						return Vector3(0, arg_68_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_69_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_69_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_70_0)
						return Vector3(0, arg_70_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_71_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_71_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_72_0)
						return Vector3(0, arg_72_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_73_0 * 3) * 3, 0.75, math.cos(arg_73_0 * 3) * 3)
					end,
					rotationFun = function(arg_74_0)
						return Vector3(0, arg_74_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_75_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_75_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_76_0)
						return Vector3(0, arg_76_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_77_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_77_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_78_0)
						return Vector3(0, arg_78_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_79_0 * 3) * 8, 0.75, math.cos(arg_79_0 * 3) * 8)
					end,
					rotationFun = function(arg_80_0)
						return Vector3(0, arg_80_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_81_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_81_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_82_0)
						return Vector3(0, arg_82_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_83_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_83_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_84_0)
						return Vector3(0, arg_84_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_85_0 * 3) * 3, 0.75, math.cos(arg_85_0 * 3) * 3)
					end,
					rotationFun = function(arg_86_0)
						return Vector3(0, arg_86_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_87_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_87_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_88_0)
						return Vector3(0, arg_88_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_89_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_89_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_90_0)
						return Vector3(0, arg_90_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_91_0 * 3) * 8, 0.75, math.cos(arg_91_0 * 3) * 8)
					end,
					rotationFun = function(arg_92_0)
						return Vector3(0, arg_92_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_93_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_93_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_94_0)
						return Vector3(0, arg_94_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_95_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_95_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_96_0)
						return Vector3(0, arg_96_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_97_0 * 3) * 3, 0.75, math.cos(arg_97_0 * 3) * 3)
					end,
					rotationFun = function(arg_98_0)
						return Vector3(0, arg_98_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_99_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_99_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_100_0)
						return Vector3(0, arg_100_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_101_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_101_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_102_0)
						return Vector3(0, arg_102_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_103_0 * 3) * 8, 0.75, math.cos(arg_103_0 * 3) * 8)
					end,
					rotationFun = function(arg_104_0)
						return Vector3(0, arg_104_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_105_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_105_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_106_0)
						return Vector3(0, arg_106_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_107_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_107_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_108_0)
						return Vector3(0, arg_108_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_109_0 * 3) * 3, 0.75, math.cos(arg_109_0 * 3) * 3)
					end,
					rotationFun = function(arg_110_0)
						return Vector3(0, arg_110_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_111_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_111_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_112_0)
						return Vector3(0, arg_112_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_113_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_113_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_114_0)
						return Vector3(0, arg_114_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_115_0 * 3) * 8, 0.75, math.cos(arg_115_0 * 3) * 8)
					end,
					rotationFun = function(arg_116_0)
						return Vector3(0, arg_116_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_117_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_117_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_118_0)
						return Vector3(0, arg_118_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_119_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_119_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_120_0)
						return Vector3(0, arg_120_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
						return Vector3(math.sin(arg_121_0 * 3) * 3, 0.75, math.cos(arg_121_0 * 3) * 3)
					end,
					rotationFun = function(arg_122_0)
						return Vector3(0, arg_122_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_123_0 * 3 + 2.512) * 3, 0.75, math.cos(arg_123_0 * 3 + 2.512) * 3)
					end,
					rotationFun = function(arg_124_0)
						return Vector3(0, arg_124_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
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
						return Vector3(math.sin(arg_125_0 * 3 - 2.512) * 3, 0.75, math.cos(arg_125_0 * 3 - 2.512) * 3)
					end,
					rotationFun = function(arg_126_0)
						return Vector3(0, arg_126_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
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
						return Vector3(math.sin(arg_127_0 * 3) * 8, 0.75, math.cos(arg_127_0 * 3) * 8)
					end,
					rotationFun = function(arg_128_0)
						return Vector3(0, arg_128_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
						return Vector3(math.sin(arg_129_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8, 0.75, math.cos(arg_129_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 8)
					end,
					rotationFun = function(arg_130_0)
						return Vector3(0, arg_130_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
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
						return Vector3(math.sin(arg_131_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8, 0.75, math.cos(arg_131_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 8)
					end,
					rotationFun = function(arg_132_0)
						return Vector3(0, arg_132_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
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
