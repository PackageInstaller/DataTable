local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 219810010,
				frame = 15
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
		totalframe = 44,
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
				id = 219820010,
				frame = 24,
				force = {
					{
						time = 0.2,
						distance = 200,
						object = "target"
					}
				}
			},
			{
				frame = 40,
				id = 219820011
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
		totalframe = 105,
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
				frame = 62,
				id = 219830010
			},
			{
				frame = 63,
				id = 219830011
			},
			{
				frame = 100,
				id = 219830012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "219820_bg",
	totalframe = 105,
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
			texture = "role/219820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/219820_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {}
	}
}

return var_0_0
