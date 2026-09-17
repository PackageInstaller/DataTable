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
					"240_atk",
					0.6
				}
			},
			{
				id = 218010010,
				frame = 17
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
					"260_skill1",
					0.6
				}
			},
			{
				frame = 28,
				id = 218020010
			},
			{
				frame = 29,
				id = 218020011
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
				frame = 24,
				id = 218030010
			},
			{
				frame = 29,
				id = 218030010
			},
			{
				frame = 34,
				id = 218030010
			},
			{
				frame = 39,
				id = 218030010
			},
			{
				frame = 44,
				id = 218030010
			},
			{
				frame = 71,
				id = 218030011
			},
			{
				frame = 73,
				id = 218030012
			},
			{
				frame = 76,
				id = 218030013
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "218020_bg",
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
			texture = "role/218020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/218020_xp",
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
