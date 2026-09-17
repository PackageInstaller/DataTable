local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 26,
		animation = "attack1",
		exe_tbl = {
			{
				id = 213110010,
				frame = 12
			}
		}
	},
	attack2 = {
		totalframe = 28,
		animation = "attack2",
		exe_tbl = {
			{
				id = 213110010,
				frame = 12
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
		totalframe = 49,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_skill",
					0.6
				}
			},
			{
				frame = 12,
				id = 213120010
			},
			{
				frame = 33,
				id = 213120012
			},
			{
				behitted = "hitdown",
				id = 213120011,
				frame = 34,
				shake = {
					x = 2,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 75,
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
				frame = 30,
				id = 213130010
			},
			{
				id = 213130011,
				frame = 33,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 213130011,
				frame = 38,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 213130011,
				frame = 44,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 213130011,
				frame = 50,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 213130011,
				behitted = "hitdown",
				frame = 65,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 66,
				id = 213130012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "213120_bg",
	totalframe = 74,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
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
			texture = "role/213120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213120_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 100,
				totalframe = 67,
				startframe = 27,
				time = 1.5
			}
		}
	}
}

return var_0_0
