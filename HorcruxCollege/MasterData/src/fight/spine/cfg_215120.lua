local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				id = 215110010,
				effect = {
					{
						ani = "attack",
						name = "25520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"25520_atk",
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
		skillattackframe = 60,
		totalframe = 50,
		animation = "skill",
		action_on_start = {
			{
				startframe = 20,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = 30
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 0,
				sound = {
					"25520_skill",
					0.6
				}
			},
			{
				id = 215120011,
				frame = 0,
				shake = {
					x = 0,
					y = 2
				},
				effect = {
					{
						ani = "attack",
						name = "25520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 1,
				id = 215120010
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	usexp1 = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 125,
		animation = "xp",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"25520_xp",
					0.6
				}
			},
			{
				id = 215130010,
				frame = 70,
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 215130010,
				frame = 90,
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 215130010,
				frame = 111,
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 215130010,
				frame = 120,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 215130010,
				frame = 124,
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 125,
				id = 215130011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfileflipx = true,
	bgfilescale = 0.6,
	bgfile = "215120_bg",
	totalframe = 124,
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
			texture = "role/25520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/25520_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 10,
			startframe = 112,
			timescale = 0.3
		},
		{
			totalframe = 3,
			startframe = 123,
			timescale = 0.6
		}
	},
	camera = {
		move = {
			{
				distance = 150,
				time = 0.1,
				distanceY = 0,
				totalframe = 65,
				startframe = 60
			}
		}
	}
}

return var_0_0
