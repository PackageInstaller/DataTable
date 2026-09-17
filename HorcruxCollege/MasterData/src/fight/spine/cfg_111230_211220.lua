local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 27,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 12,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack1",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 950,
	offsetZ = 1,
	filename = "111230_211220_effect",
	initpos = {
		offsetY = 1.02,
		offsetX = 1.1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 211210010
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 28,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 4,
			sound = {
				"202420_atk",
				0.6
			}
		},
		{
			frame = 14,
			id = 211210011
		}
	}
}
var_0_0.skill1 = {
	{
		{
			method = "useSkill",
			param = "useskill1"
		}
	}
}
var_0_0.useskill1 = {
	totalframe = 45,
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
			frame = 26,
			id = 211220010
		},
		{
			frame = 27,
			id = 211220011
		},
		{
			frame = 28,
			id = 211220012
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp1"
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 102,
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
			frame = 32,
			id = 211230010
		},
		{
			frame = 66,
			id = 211230012
		},
		{
			frame = 75,
			id = 211230013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "211220_bg",
	totalframe = 102,
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
			texture = "role/211220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/211220_xp",
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
