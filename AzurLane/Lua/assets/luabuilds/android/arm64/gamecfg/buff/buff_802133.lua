return {
	effect_list = {
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 3,
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
							2,
							0,
							0
						}
					}
				},
				centerPosFun = function(arg_1_0)
					return Vector3(3, 0, 0.5)
				end,
				rotationFun = function(arg_2_0)
					return Vector3(0, 192, 0)
				end
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onShieldBroken"
			},
			arg_list = {
				skill_id = 802131,
				shieldBuffID = 802133,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onRemove"
			},
			arg_list = {
				skill_id = 802131,
				target = "TargetSelf"
			}
		}
	},
	{
		effect_list = {
			{
				id = 1,
				type = "BattleBuffShieldWall",
				trigger = {
					"onUpdate"
				},
				arg_list = {
					effect = "shield02",
					count = 3,
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_3_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_4_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
					"onUpdate"
				},
				arg_list = {
					effect = "shield02",
					count = 3,
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_5_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_6_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_7_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_8_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_9_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_10_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
					"onUpdate"
				},
				arg_list = {
					effect = "shield02",
					count = 5,
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_11_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_12_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
					"onUpdate"
				},
				arg_list = {
					effect = "shield02",
					count = 5,
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_13_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_14_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
					"onUpdate"
				},
				arg_list = {
					effect = "shield02",
					count = 6,
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_15_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_16_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
					"onUpdate"
				},
				arg_list = {
					effect = "shield02",
					count = 6,
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_17_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_18_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
					"onUpdate"
				},
				arg_list = {
					effect = "shield02",
					count = 7,
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_19_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_20_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
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
					"onUpdate"
				},
				arg_list = {
					effect = "shield02",
					count = 8,
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
								2,
								0,
								0
							}
						}
					},
					centerPosFun = function(arg_21_0)
						return Vector3(3, 0, 0.5)
					end,
					rotationFun = function(arg_22_0)
						return Vector3(0, 192, 0)
					end
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onShieldBroken"
				},
				arg_list = {
					skill_id = 802131,
					shieldBuffID = 802133,
					target = "TargetSelf"
				}
			},
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onRemove"
				},
				arg_list = {
					skill_id = 802131,
					target = "TargetSelf"
				}
			}
		}
	},
	time = 8,
	name = "",
	init_effect = "",
	id = 802133,
	picture = "",
	desc = "",
	stack = 1,
	color = "blue",
	icon = 802130,
	last_effect = ""
}
