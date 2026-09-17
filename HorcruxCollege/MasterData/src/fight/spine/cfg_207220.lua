local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 24,
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
				frame = 11,
				id = 207210010
			}
		}
	},
	attack2 = {
		totalframe = 24,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				frame = 12,
				id = 207210010
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
		totalframe = 48,
		turnbacklimit = true,
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
				frame = 15,
				id = 207220010
			},
			{
				frame = 25,
				id = 207220010
			},
			{
				frame = 27,
				id = 207220011
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
		totalframe = 103,
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
				frame = 45,
				id = 207230010
			},
			{
				frame = 55,
				id = 207230010
			},
			{
				frame = 65,
				id = 207230010
			},
			{
				frame = 75,
				id = 207230010
			},
			{
				frame = 38,
				id = 207230011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "207220_bg",
	totalframe = 103,
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
			texture = "role/207220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
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
		move = {
			{
				distance = 110,
				totalframe = 110,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
