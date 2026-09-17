local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 25,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 213510010,
				frame = 13
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
					"203020_attack",
					0.6
				}
			},
			{
				id = 213510010,
				frame = 9
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
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_skill_xp",
					0.7
				}
			},
			{
				frame = 24,
				id = 213520010
			},
			{
				frame = 36,
				id = 213520011
			},
			{
				frame = 37,
				id = 213520012
			},
			{
				frame = 38,
				id = 213520013
			},
			{
				frame = 39,
				id = 213520014
			}
		}
	},
	usexp = {
		totalframe = 101,
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
				frame = 1,
				id = 213530010
			},
			{
				frame = 31,
				id = 213530011
			},
			{
				frame = 55,
				id = 213530011
			},
			{
				frame = 79,
				id = 213530014
			},
			{
				frame = 80,
				id = 213530011
			},
			{
				frame = 83,
				id = 213530013
			},
			{
				frame = 84,
				id = 213530012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "213520_bg",
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
			texture = "role/213520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213520_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 250,
				time = 0.5,
				distanceY = 0,
				totalframe = 25,
				startframe = 30
			}
		}
	}
}

return var_0_0
