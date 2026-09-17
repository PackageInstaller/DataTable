local var_0_0 = {
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 8,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22720_attack",
					0.6
				}
			},
			{
				frame = 14,
				id = 227310010,
				effect = {
					{
						ani = "attack",
						name = "12710_22700_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22720_attack",
					0.6
				}
			},
			{
				frame = 14,
				id = 227310010,
				effect = {
					{
						ani = "attack",
						name = "12710_22700_effect",
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
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		skillattackframe = 45,
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22720_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 227320010,
				frame = 24,
				force = {
					{
						time = 0.25,
						shutdown = true,
						distance = 200,
						object = "target"
					}
				}
			},
			{
				frame = 25,
				id = 227320011
			},
			{
				frame = 26,
				id = 227320012
			}
		}
	},
	usexp = {
		totalframe = 70,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22720_xp",
					0.6
				}
			},
			{
				id = 227330010,
				behitted = "hitdown",
				frame = 44,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				id = 227330012,
				behitted = "hitdown",
				frame = 43,
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = 250,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 227330011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 70,
	bgfile = "marry_bg",
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
			texture = "role/22730.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22730_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 38,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 13,
				startframe = 30
			}
		},
		move = {
			{
				distance = 150,
				time = 0.3,
				distanceY = 0,
				totalframe = 25,
				startframe = 46
			}
		}
	}
}

return var_0_0
