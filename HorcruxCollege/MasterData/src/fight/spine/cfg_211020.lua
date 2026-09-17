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
					"201820_attack",
					0.6
				}
			},
			{
				id = 211010010,
				frame = 13
			},
			{
				id = 211010010,
				frame = 16
			},
			{
				id = 211010010,
				frame = 22
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
		totalframe = 60,
		turnbacklimit = false,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21100_skill",
					0.6
				}
			},
			{
				frame = 35,
				id = 211020010
			}
		}
	},
	usexp = {
		totalframe = 90,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201220_xp",
					0.6
				}
			},
			{
				frame = 52,
				id = 211030010
			},
			{
				frame = 55,
				id = 211030010
			},
			{
				frame = 60,
				id = 211030010
			},
			{
				frame = 65,
				id = 211030010
			},
			{
				frame = 66,
				id = 211030011
			},
			{
				frame = 67,
				id = 211030012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "211020_bg",
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
			texture = "role/211020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/211020_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 1.05,
				totalframe = 2,
				startframe = 51
			},
			{
				scale = 1.1,
				totalframe = 2,
				startframe = 53
			},
			{
				scale = 1.05,
				totalframe = 2,
				startframe = 55
			},
			{
				scale = 1.1,
				totalframe = 2,
				startframe = 57
			}
		},
		move = {
			{
				distance = 120,
				time = 0.8,
				distanceY = 0,
				totalframe = 40,
				startframe = 15
			}
		}
	}
}

return var_0_0
