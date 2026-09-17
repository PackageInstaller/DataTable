local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
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
				frame = 22,
				id = 201110010
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
					"20100_attack",
					0.6
				}
			},
			{
				frame = 22,
				id = 201110011
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
		totalframe = 30,
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
				frame = 25,
				id = 201120010
			},
			{
				frame = 26,
				id = 201120011
			},
			{
				frame = 27,
				id = 201120012
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
		totalframe = 85,
		xpeffect = "xp_effect",
		turnbacklimit = true,
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
				frame = 50,
				id = 201130010
			},
			{
				frame = 51,
				id = 201120011
			},
			{
				frame = 72,
				id = 201120012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "201120_bg",
	totalframe = 85,
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
			texture = "role/201120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/201120_xp",
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
			totalframe = 85,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 85,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
