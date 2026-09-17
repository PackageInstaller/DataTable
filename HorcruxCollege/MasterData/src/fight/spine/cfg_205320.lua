local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 10,
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
	filename = "205320_effect",
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
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				id = 205310010
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 35,
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
			frame = 10,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack2",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "205320_effect",
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
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				id = 205310010
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
	totalframe = 47,
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
			frame = 29,
			id = 205320010
		},
		{
			frame = 32,
			id = 205320010
		},
		{
			frame = 34,
			id = 205320012
		},
		{
			frame = 36,
			id = 205320011
		},
		{
			frame = 38,
			id = 205320013
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
	totalframe = 94,
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
			id = 205330010
		},
		{
			frame = 41,
			id = 205330010
		},
		{
			frame = 50,
			id = 205330010
		},
		{
			frame = 59,
			id = 205330010
		},
		{
			frame = 68,
			id = 205330010
		},
		{
			frame = 80,
			id = 205330011
		},
		{
			frame = 82,
			id = 205330012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "205320_bg",
	totalframe = 94,
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
			texture = "role/205320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/205320_xp",
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
