local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 28,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				frame = 12,
				id = 214910010
			}
		}
	},
	attack2 = {
		totalframe = 26,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				frame = 15,
				id = 214910012
			},
			{
				frame = 16,
				id = 214910011
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
		totalframe = 50,
		turnbacklimit = false,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				frame = 1,
				id = 214920010
			},
			{
				frame = 5,
				id = 214920011
			},
			{
				id = 214920012,
				behitted = "hitdown",
				frame = 27
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
		totalframe = 88,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"241_xp",
					0.6
				}
			},
			{
				id = 214930010,
				behitted = "hitdown",
				frame = 62
			},
			{
				frame = 65,
				id = 214930010
			},
			{
				frame = 68,
				id = 214930010
			},
			{
				frame = 71,
				id = 214930011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "214920_bg",
	totalframe = 87,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/205820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/205820_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 110,
			intime = 0.2
		},
		move = {}
	}
}

return var_0_0
