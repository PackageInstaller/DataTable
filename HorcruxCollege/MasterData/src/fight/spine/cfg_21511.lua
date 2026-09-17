local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				id = 21510001,
				frame = 10,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				id = 21510001,
				frame = 10,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	attack3 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				id = 21510001,
				frame = 10,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 40,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 150
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 21520001,
				frame = 19,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 21520001,
				frame = 21,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 21520001,
				frame = 24,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	useskill1_1 = {
		totalframe = 40,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 150
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 21520101,
				frame = 19,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 21520101,
				frame = 21,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 21520101,
				frame = 24,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	useskill1_2 = {
		totalframe = 40,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 150
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 21520201,
				frame = 19,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 21520201,
				frame = 21,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 21520201,
				frame = 24,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1_3 = {
		totalframe = 40,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 150
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 21520301,
				frame = 19,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 21520301,
				frame = 21,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 21520301,
				frame = 24,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "xp_begin"
			}
		}
	},
	xp_begin = {
		anitype = "released",
		xpeffect = "xp_effect",
		totalframe = 72,
		turnbacklimit = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = 200
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 21541001,
				frame = 14,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack"
				}
			},
			{
				id = 21541001,
				frame = 16,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack"
				}
			},
			{
				id = 21541001,
				frame = 18,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack"
				}
			},
			{
				id = 21541001,
				frame = 20,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack"
				}
			},
			{
				id = 21541001,
				frame = 22,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack"
				}
			},
			{
				id = 21541001,
				frame = 24,
				effect = {
					{
						ani = "attack1",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack"
				}
			},
			{
				id = 21541002,
				frame = 55,
				effect = {
					{
						ani = "skill1_attack",
						name = "21500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_xp2"
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 71,
	bgfile = "21500_bg",
	locktarget = {
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/21511.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21505_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 29,
			timescale = 0.1
		},
		{
			totalframe = 3,
			startframe = 45,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 18,
				startframe = 5,
				outtime = 0.1
			},
			{
				scale = 0.8,
				totalframe = 25,
				startframe = 26
			}
		},
		move = {
			{
				distance = 70,
				totalframe = 30,
				startframe = 0,
				time = 0.1
			},
			{
				pos = "target",
				totalframe = 20,
				startframe = 31,
				time = 0.1
			}
		}
	}
}

return var_0_0
