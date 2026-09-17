local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202820_attack",
					0.6
				}
			},
			{
				id = 215610010,
				frame = 16
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
					"28820_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 215620010
			},
			{
				frame = 40,
				id = 215620011
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
		totalframe = 139,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28820_xp",
					0.6
				}
			},
			{
				frame = 45,
				id = 215630011
			},
			{
				frame = 80,
				id = 215630012
			},
			{
				frame = 105,
				id = 215630010
			},
			{
				frame = 130,
				id = 215630013
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "215620_bg",
	totalframe = 138,
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
			texture = "role/215620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/215620_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
