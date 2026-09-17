local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				id = 20010001,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "20000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20000_attack",
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
				id = 20010001,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "20000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20000_attack",
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
				id = 20010001,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "20000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20000_attack",
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				id = 20020001,
				frame = 10,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 20020001,
				frame = 17,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 20020001,
				frame = 25,
				sound = {
					"20000_attack",
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				id = 20020101,
				frame = 10,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 20020101,
				frame = 17,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 20020101,
				frame = 25,
				sound = {
					"20000_attack",
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				id = 20020201,
				frame = 10,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 20020201,
				frame = 17,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 20020201,
				frame = 25,
				sound = {
					"20000_attack",
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				id = 20020301,
				frame = 10,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 20020301,
				frame = 17,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				id = 20020301,
				frame = 25,
				sound = {
					"20000_attack",
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
		totalframe = 40,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		exe_tbl = {
			{
				id = 20030002,
				frame = 15,
				sound = {
					"20000_xp1"
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack"
			}
		}
	},
	xp_attack = {
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_type = "crash",
		totalframe = 31,
		animation = "xp_attack",
		action_on_start = {
			{
				startframe = 0.5,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 360,
							time = 0.3
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 20030001,
				frame = 10,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 110,
						object = "target"
					}
				},
				forceY = {
					speed = 500
				},
				shake = {
					x = 4,
					y = 30
				},
				sound = {
					"20000_xp2"
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 70,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/20005.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 50,
			timescale = 0.13
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 50,
				startframe = 0
			}
		}
	}
}

return var_0_0
