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
				frame = 13,
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
	filename = "205520_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 205510010
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
				"201720_skill",
				0.6
			}
		},
		{
			frame = 27,
			id = 205520010
		},
		{
			frame = 40,
			id = 205520011
		},
		{
			frame = 41,
			id = 205520012
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
	totalframe = 90,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 30,
			sound = {
				"201720_xp",
				0.6
			}
		},
		{
			frame = 25,
			id = 205530011
		},
		{
			frame = 70,
			id = 205530010
		},
		{
			frame = 80,
			id = 205530012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "205520_bg",
	totalframe = 90,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
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
			texture = "role/205520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
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
			totalframe = 110,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 110,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
