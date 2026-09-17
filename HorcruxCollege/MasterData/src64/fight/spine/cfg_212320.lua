local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 34,
		animation = "attack1",
		exe_tbl = {
			{
				id = 212310010,
				frame = 14
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
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		skillattackframe = 45,
		totalframe = 47,
		turnbacklimit = true,
		animation = "skill",
		action_on_start = {
			{
				startframe = 17,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 80
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 212320010,
				frame = 20,
				shake = {
					x = 2,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 120,
						object = "target"
					}
				}
			},
			{
				frame = 21,
				id = 212320011
			}
		}
	},
	usexp = {
		totalframe = 77,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_xp1"
				}
			},
			{
				id = 212330010,
				frame = 54,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 212330010,
				frame = 56,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 212330010,
				frame = 58,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 212330010,
				frame = 60,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 62,
				id = 212330011
			},
			{
				frame = 64,
				id = 212330012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = 150,
	initpos = -150,
	bgfile = "212320_bg",
	totalframe = 77,
	locktarget = {
		mindistance = 250,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "22300_bg"
		}
	},
	inserteffect = {
		{
			texture = "role/212320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/212320_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 55,
			timescale = 0.15
		}
	},
	camera = {
		zoom = {
			{
				scale = 1,
				totalframe = 22,
				startframe = 48
			}
		},
		move = {
			{
				distance = 50,
				totalframe = 27,
				startframe = 43,
				time = 0.1
			}
		}
	}
}

return var_0_0
