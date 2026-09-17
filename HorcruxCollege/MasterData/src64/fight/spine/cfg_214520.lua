local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 24,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 214510010,
				frame = 15
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
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
		totalframe = 52,
		turnbacklimit = false,
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
				frame = 33,
				id = 214520010
			},
			{
				frame = 35,
				id = 214520010
			},
			{
				frame = 37,
				id = 214520011
			},
			{
				frame = 38,
				id = 214520012
			}
		}
	},
	usexp = {
		totalframe = 108,
		xpeffect = "xp_effect",
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
				frame = 61,
				id = 214530011
			},
			{
				frame = 64,
				id = 214530010
			},
			{
				frame = 66,
				id = 214530010
			},
			{
				frame = 68,
				id = 214530010
			},
			{
				frame = 70,
				id = 214530010
			},
			{
				frame = 93,
				id = 214530012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 108,
	bgfile = "214520_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/214520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/214520_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
