local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
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
				frame = 14,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "210420_effect",
	initpos = {
		offsetY = 0.25,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 210410010
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
			frame = 4,
			id = 210420010
		},
		{
			frame = 6,
			id = 210420011
		},
		{
			frame = 8,
			id = 210420012
		},
		{
			frame = 34,
			id = 210420014
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
			frame = 1,
			sound = {
				"241_xp",
				0.6
			}
		},
		{
			frame = 43,
			id = 210430010
		},
		{
			frame = 53,
			id = 210430010
		},
		{
			frame = 72,
			id = 210430010
		},
		{
			frame = 80,
			id = 210430011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "210420_bg",
	totalframe = 90,
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
			texture = "role/210420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/210420_xp",
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
				totalframe = 66,
				startframe = 39,
				time = 1
			}
		}
	}
}

return var_0_0
