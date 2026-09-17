local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 14,
				sound = {
					"203620_attack2",
					0.6
				}
			},
			{
				frame = 16,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "215420_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 1.7,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "attack",
		exe_tbl = {
			{
				id = 215410010,
				frame = 5
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
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
	totalframe = 55,
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
			frame = 17,
			id = 215420010
		},
		{
			frame = 35,
			id = 215420011
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
	totalframe = 80,
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
			frame = 54,
			id = 215430010
		},
		{
			frame = 65,
			id = 215430011
		},
		{
			frame = 70,
			id = 215430012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "215420_bg",
	totalframe = 80,
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
			texture = "role/215420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/215420_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 200,
				totalframe = 50,
				startframe = 25,
				time = 0.1
			}
		}
	}
}

return var_0_0
