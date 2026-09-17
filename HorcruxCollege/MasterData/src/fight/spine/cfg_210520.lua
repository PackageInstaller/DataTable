local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 210510010,
				frame = 10
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
		totalframe = 45,
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
				frame = 15,
				id = 210520010
			},
			{
				frame = 29,
				id = 210520011
			},
			{
				frame = 30,
				id = 210520012
			}
		}
	},
	usexp = {
		totalframe = 121,
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
				frame = 106,
				id = 210530010
			},
			{
				frame = 107,
				id = 210530011
			},
			{
				frame = 108,
				id = 210530012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 120,
	bgfile = "210520_bg",
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
			texture = "role/210520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/210520_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 20,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 1,
				totalframe = 87,
				startframe = 35
			}
		},
		move = {}
	}
}

return var_0_0
