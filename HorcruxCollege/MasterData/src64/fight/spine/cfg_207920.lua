local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 32,
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
				frame = 14,
				id = 207910011
			},
			{
				frame = 20,
				id = 207910010
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
				frame = 29,
				id = 207920010
			},
			{
				frame = 30,
				id = 207920011
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
				frame = 46,
				id = 207930010
			},
			{
				frame = 52,
				id = 207930011
			},
			{
				frame = 57,
				id = 207930010
			},
			{
				frame = 69,
				id = 207930011
			},
			{
				frame = 81,
				id = 207930010
			},
			{
				frame = 81,
				id = 207930012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "206820_bg",
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
			texture = "role/207920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/207920_xp",
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
