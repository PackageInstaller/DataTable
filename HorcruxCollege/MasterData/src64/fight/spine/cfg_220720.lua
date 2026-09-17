local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_atk",
					0.6
				}
			},
			{
				id = 220710010,
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
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"20120-skill",
					0.6
				}
			},
			{
				frame = 20,
				id = 220720010
			},
			{
				frame = 30,
				id = 220720010
			},
			{
				frame = 32,
				id = 220720011
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
		totalframe = 101,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"260_xp",
					0.6
				}
			},
			{
				frame = 72,
				id = 220730010
			},
			{
				id = 220730011,
				behitted = "hitdown",
				frame = 75
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "220720_bg",
	totalframe = 101,
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
			texture = "role/220720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/220720_xp",
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
