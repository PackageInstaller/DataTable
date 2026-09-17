local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 33,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"25100_atk",
					0.6
				}
			},
			{
				id = 25110002,
				frame = 21,
				effect = {
					{
						ani = "attack",
						name = "15110_25100_effect",
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
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
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
		skillattackframe = 20,
		totalframe = 25,
		nextani = true,
		animation = "skill",
		action_on_start = {
			{
				startframe = 13,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 5,
							posx = -200
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill_back"
			}
		},
		exe_tbl = {
			{
				id = 25120001,
				frame = 14,
				shake = {
					x = 0,
					y = 2
				},
				sound = {
					"25100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill_attack",
						name = "15110_25100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.25,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				}
			}
		}
	},
	useskill_back = {
		totalframe = 20,
		nextani = true,
		animation = "skill",
		action_on_start = {
			{
				startframe = 13,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 5,
							posx = -250
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 25120002,
				frame = 14,
				shake = {
					x = 0,
					y = 2
				},
				sound = {
					"25100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill_attack",
						name = "15110_25100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 120,
		animation = "xp",
		action_on_start = {
			{
				startframe = 5,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = 150
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"25100_xp",
					0.6
				}
			},
			{
				id = 25130001,
				frame = 48,
				behitted = "hitdown",
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "skill_attack",
						name = "15110_25100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 1500
					}
				}
			},
			{
				frame = 63,
				behitted = "hitdown",
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "skill_attack",
						name = "25100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = -1500
					}
				},
				force = {
					{
						time = 0.25,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			},
			{
				frame = 70,
				id = 25130002
			},
			{
				frame = 64,
				id = 25330003
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 120,
	bgfile = "marry_bg",
	locktarget = {
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "xp"
		}
	},
	inserteffect = {
		{
			texture = "role/25120.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/25100_xp",
				1
			}
		},
		{
			donotlock = true,
			isloop = false,
			file = "test/25100_bg2",
			ani = "xp",
			startframe = 1,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 58,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {},
		move = {
			{
				distanceY = -100,
				totalframe = 96,
				startframe = 36,
				time = 0.2
			},
			{
				distanceY = 100,
				totalframe = 6,
				startframe = 132,
				time = 0.2
			}
		}
	}
}

return var_0_0
