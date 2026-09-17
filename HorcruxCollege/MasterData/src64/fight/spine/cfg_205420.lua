local var_0_0 = {
	extra = {},
	xpeffect = {},
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
				id = 205410011,
				frame = 12
			}
		}
	},
	attack = {
		totalframe = 30,
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
				id = 205410010,
				frame = 13
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"25320_skill",
					0.6
				}
			},
			{
				id = 205420010,
				behitted = "hitdown",
				frame = 25
			},
			{
				frame = 35,
				id = 205420011
			}
		}
	},
	usexp = {
		totalframe = 95,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1
			},
			{
				frame = 55,
				id = 205430010
			},
			{
				frame = 60,
				id = 205430011
			},
			{
				frame = 65,
				id = 205430012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 108,
	bgfile = "205420_bg",
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
			texture = "role/205420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 37,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.9,
				totalframe = 90,
				startframe = 0
			}
		},
		move = {
			{
				distance = 0,
				time = 0.5,
				distanceY = 0,
				totalframe = 90,
				startframe = 0
			}
		}
	}
}

return var_0_0
