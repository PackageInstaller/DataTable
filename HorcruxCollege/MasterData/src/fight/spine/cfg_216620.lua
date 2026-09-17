local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 26,
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
				id = 216610010
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
				frame = 16,
				id = 216620010
			},
			{
				frame = 18,
				id = 216620011
			},
			{
				id = 216620012,
				behitted = "hitdown",
				frame = 2
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
		totalframe = 91,
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
				id = 216630010,
				behitted = "hitdown",
				frame = 56
			},
			{
				frame = 66,
				id = 216630011
			},
			{
				frame = 66,
				id = 216630013
			},
			{
				frame = 80,
				id = 216630012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1.3,
	bgfile = "216620_bg",
	totalframe = 90,
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
			texture = "role/216620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26720_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 1.3,
				anchory = 200,
				outtime = 0.3,
				totalframe = 28,
				intime = 0.2
			},
			{
				startframe = 40,
				scale = 0.9,
				anchory = 100,
				outtime = 0.2,
				totalframe = 28,
				intime = 0.2
			}
		},
		move = {
			{
				distanceY = 300,
				totalframe = 28,
				startframe = 0,
				time = 0.3
			},
			{
				distance = 200,
				totalframe = 28,
				startframe = 40,
				time = 0.3
			}
		}
	}
}

return var_0_0
