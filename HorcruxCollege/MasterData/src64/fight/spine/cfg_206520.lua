local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
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
				frame = 11,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "206520_effect",
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
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 206510010
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
			frame = 20,
			id = 206520010
		},
		{
			frame = 23,
			id = 206520010
		},
		{
			frame = 26,
			id = 206520011
		},
		{
			frame = 28,
			id = 206520012
		},
		{
			frame = 30,
			id = 206520013
		},
		{
			frame = 33,
			id = 206520014
		},
		{
			frame = 36,
			id = 206520015
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
	totalframe = 66,
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
			frame = 35,
			id = 206530010
		},
		{
			frame = 36,
			id = 206530010
		},
		{
			frame = 37,
			id = 206530011
		},
		{
			frame = 38,
			id = 206530012
		},
		{
			frame = 39,
			id = 206530013
		},
		{
			frame = 40,
			id = 206530014
		},
		{
			frame = 41,
			id = 206530015
		},
		{
			frame = 50,
			id = 206530016
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "206520_bg",
	totalframe = 66,
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
			texture = "role/206520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/206520_xp",
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
		move = {
			{
				distance = 110,
				totalframe = 66,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
