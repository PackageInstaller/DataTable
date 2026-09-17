local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 22,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				frame = 10,
				id = 208310010
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
					"22120_attack",
					0.6
				}
			},
			{
				frame = 10,
				id = 208310010
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
		totalframe = 31,
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
				frame = 9,
				id = 208320010
			},
			{
				frame = 14,
				id = 208320010
			},
			{
				frame = 25,
				id = 208320010
			},
			{
				frame = 26,
				id = 208320011
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
		totalframe = 59,
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
				frame = 11,
				id = 208330010
			},
			{
				frame = 11,
				id = 208330012
			},
			{
				frame = 15,
				id = 208330010
			},
			{
				frame = 15,
				id = 208330012
			},
			{
				frame = 18,
				id = 208330010
			},
			{
				frame = 18,
				id = 208330012
			},
			{
				frame = 23,
				id = 208330010
			},
			{
				frame = 23,
				id = 208330012
			},
			{
				frame = 26,
				id = 208330010
			},
			{
				frame = 26,
				id = 208330012
			},
			{
				frame = 31,
				id = 208330010
			},
			{
				frame = 31,
				id = 208330012
			},
			{
				frame = 35,
				id = 208330010
			},
			{
				frame = 35,
				id = 208330012
			},
			{
				frame = 39,
				id = 208330010
			},
			{
				frame = 39,
				id = 208330012
			},
			{
				frame = 43,
				id = 208330010
			},
			{
				frame = 43,
				id = 208330012
			},
			{
				frame = 55,
				id = 208330010
			},
			{
				frame = 55,
				id = 208330012
			},
			{
				frame = 55,
				id = 208330011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "208320_bg",
	totalframe = 59,
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
			texture = "role/208320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/208320_xp",
				0.7
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
