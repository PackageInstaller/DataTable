local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 23,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				sound = {
					"28820_attack",
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
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "218420_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				id = 218410010
			},
			{
				frame = 5,
				id = 218410011
			}
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
				"28820_skill",
				0.6
			}
		},
		{
			frame = 10,
			id = 218420010
		},
		{
			frame = 20,
			id = 218420011
		},
		{
			frame = 40,
			id = 218420012
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
	totalframe = 119,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28820_xp",
				0.6
			}
		},
		{
			frame = 53,
			id = 218430010
		},
		{
			frame = 60,
			id = 218430011
		},
		{
			frame = 115,
			id = 218430012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "218420_bg",
	totalframe = 119,
	locktarget = {
		locktargetpool = "teammate",
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
			texture = "role/218420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/218420_xp",
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
