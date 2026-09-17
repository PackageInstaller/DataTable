local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"202820_attack",
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
	speed = 600,
	offsetZ = 1,
	filename = "210620_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 210610010
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
	totalframe = 43,
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
			frame = 15,
			id = 210620010
		},
		{
			frame = 18,
			id = 210620011
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
	totalframe = 110,
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
			frame = 80,
			id = 210630010
		},
		{
			frame = 90,
			id = 210630011
		},
		{
			frame = 91,
			id = 210630012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "210620_bg",
	totalframe = 110,
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
			texture = "role/210620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/210620_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 66,
			intime = 0.2
		},
		move = {}
	}
}

return var_0_0
