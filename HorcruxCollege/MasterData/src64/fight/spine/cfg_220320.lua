local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 27,
		animation = "attack1",
		exe_tbl = {
			{
				id = 220310010,
				frame = 15,
				sound = {
					"203020_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 27,
		animation = "attack2",
		exe_tbl = {
			{
				id = 220310010,
				frame = 15,
				sound = {
					"203020_attack",
					0.6
				}
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
		totalframe = 55,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 2,
				id = 220320010
			},
			{
				frame = 28,
				id = 220320011
			},
			{
				frame = 40,
				id = 220320012
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
		totalframe = 106,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_xp",
					0.6
				}
			},
			{
				frame = 52,
				id = 220330010
			},
			{
				frame = 57,
				id = 220330010
			},
			{
				frame = 62,
				id = 220330010
			},
			{
				frame = 67,
				id = 220330010
			},
			{
				frame = 72,
				id = 220330010
			},
			{
				frame = 78,
				id = 220330011
			},
			{
				frame = 100,
				id = 220330012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	totalframe = 106,
	bgfile = "220320_bg",
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
			texture = "role/220320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23820_xp",
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
