local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
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
				frame = 13,
				id = 208110010
			}
		}
	},
	attack2 = {
		totalframe = 25,
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
				frame = 13,
				id = 208110011
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
		totalframe = 46,
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
				frame = 11,
				id = 208120010
			},
			{
				frame = 12,
				id = 208120011
			},
			{
				frame = 14,
				id = 208120011
			},
			{
				frame = 26,
				id = 208120012
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
		totalframe = 98,
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
				frame = 32,
				id = 208130010
			},
			{
				frame = 33,
				id = 208130012
			},
			{
				frame = 50,
				id = 208130010
			},
			{
				frame = 52,
				id = 208130012
			},
			{
				frame = 70,
				id = 208130010
			},
			{
				frame = 73,
				id = 208130012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "208120_bg",
	totalframe = 98,
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
			texture = "role/208120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/208120_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 110,
				totalframe = 98,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
