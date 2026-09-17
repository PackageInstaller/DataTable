local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 22,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21520_attack",
					0.6
				}
			},
			{
				frame = 10,
				id = 21510101,
				effect = {
					{
						ani = "attack",
						name = "11510_21520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 22,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21520_attack",
					0.6
				}
			},
			{
				frame = 10,
				id = 21510101,
				effect = {
					{
						ani = "attack",
						name = "11510_21520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack3 = {
		totalframe = 22,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21520_attack",
					0.6
				}
			},
			{
				frame = 10,
				id = 21510101,
				effect = {
					{
						ani = "attack",
						name = "11510_21520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "skill_begin1"
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "skill_begin1_1"
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "skill_begin1_2"
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "skill_begin1_3"
			}
		}
	},
	skill_begin1 = {
		totalframe = 25,
		nextani = true,
		animation = "skill_1",
		action_on_complete = {
			{
				method = "useSkill",
				param = "skill_attack1"
			}
		}
	},
	skill_attack1 = {
		turnbacklimit = true,
		totalframe = 15,
		animation = "skill_2",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 0
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 300,
					maxcatapult = 1,
					condition = "random"
				}
			},
			{
				method = "useSkill",
				param = "skill_attack1"
			}
		},
		exe_tbl = {
			{
				id = 21521001,
				frame = 5,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	skill_begin1_1 = {
		totalframe = 25,
		nextani = true,
		animation = "skill_1",
		action_on_complete = {
			{
				method = "useSkill",
				param = "skill_attack1_1"
			}
		}
	},
	skill_attack1_1 = {
		turnbacklimit = true,
		totalframe = 15,
		animation = "skill_2",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 0
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 300,
					maxcatapult = 1,
					condition = "random"
				}
			},
			{
				method = "useSkill",
				param = "skill_attack1_1"
			}
		},
		exe_tbl = {
			{
				id = 21521101,
				frame = 5,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	skill_begin1_2 = {
		totalframe = 25,
		nextani = true,
		animation = "skill_1",
		action_on_complete = {
			{
				method = "useSkill",
				param = "skill_attack1_2"
			}
		}
	},
	skill_attack1_2 = {
		turnbacklimit = true,
		totalframe = 15,
		animation = "skill_2",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 0
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 300,
					maxcatapult = 1,
					condition = "random"
				}
			},
			{
				method = "useSkill",
				param = "skill_attack1_2"
			}
		},
		exe_tbl = {
			{
				id = 21521201,
				frame = 5,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	skill_begin1_3 = {
		totalframe = 25,
		nextani = true,
		animation = "skill_1",
		action_on_complete = {
			{
				method = "useSkill",
				param = "skill_attack1_3"
			}
		}
	},
	skill_attack1_3 = {
		turnbacklimit = true,
		totalframe = 15,
		animation = "skill_2",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 0
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 300,
					maxcatapult = 1,
					condition = "random"
				}
			},
			{
				method = "useSkill",
				param = "skill_attack1_3"
			}
		},
		exe_tbl = {
			{
				id = 21521301,
				frame = 5,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 116,
		xpeffect = "xp_effect",
		anitype = "released",
		animation = "xp",
		action_on_start = {
			{
				startframe = 45,
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
				frame = 1,
				sound = "21520_xp1"
			},
			{
				frame = 51,
				id = 21550001
			},
			{
				frame = 60,
				id = 21550001
			},
			{
				frame = 68,
				id = 21550001
			},
			{
				frame = 75,
				id = 21550001
			},
			{
				frame = 81,
				id = 21550001
			},
			{
				frame = 90,
				id = 21550002
			},
			{
				frame = 95,
				id = 21550002
			},
			{
				frame = 99,
				id = 21550002
			},
			{
				frame = 101,
				id = 21550002
			},
			{
				frame = 103,
				id = 21550002
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 115,
	bgfile = "marry_bg",
	locktarget = {
		mindistance = 200,
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
			texture = "role/21520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21520_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 87,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 40,
				startframe = 0
			},
			{
				scale = 0.8,
				totalframe = 60,
				startframe = 48
			}
		},
		move = {
			{
				pos = "target",
				time = 0.1,
				distance = -50,
				totalframe = 66,
				startframe = 42
			}
		}
	}
}

return var_0_0
