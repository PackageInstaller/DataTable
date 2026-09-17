local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack2 = {
		totalframe = 27,
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
				id = 210210010,
				frame = 13
			}
		}
	},
	attack1 = {
		totalframe = 27,
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
				id = 210210010,
				frame = 11
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
				frame = 9,
				id = 210220010
			},
			{
				frame = 19,
				id = 210220010
			},
			{
				frame = 38,
				id = 210220010
			},
			{
				frame = 39,
				id = 210220011
			}
		}
	},
	usexp = {
		totalframe = 95,
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
				frame = 26,
				id = 210230010
			},
			{
				frame = 39,
				id = 210230010
			},
			{
				frame = 52,
				id = 210230010
			},
			{
				frame = 66,
				id = 210230010
			},
			{
				frame = 80,
				id = 210230010
			},
			{
				frame = 81,
				id = 210230011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 94,
	bgfile = "210220_bg",
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
			texture = "role/210220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 90,
				startframe = 2
			}
		},
		move = {
			{
				distance = 250,
				time = 2,
				distanceY = 0,
				totalframe = 65,
				startframe = 16
			}
		}
	}
}

return var_0_0
