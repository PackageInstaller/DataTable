local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 15,
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
	filename = "217420_effect",
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
				frame = 6,
				id = 217410010
			}
		}
	}
}
var_0_0.extra.skill = {
	movingani = "skill_run",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "217420_effect",
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
		totalframe = 32,
		animation = "skill",
		exe_tbl = {
			{
				frame = 11,
				id = 217420010
			},
			{
				frame = 16,
				id = 217420011
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
	totalframe = 50,
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
			frame = 35,
			bullet = "skill"
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
	totalframe = 116,
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
			frame = 69,
			id = 217430012
		},
		{
			frame = 70,
			id = 217430010
		},
		{
			frame = 87,
			id = 217430011
		},
		{
			frame = 94,
			id = 217430011
		},
		{
			frame = 101,
			id = 217430011
		},
		{
			frame = 108,
			id = 217430011
		},
		{
			frame = 115,
			id = 217430011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "217420_bg",
	totalframe = 116,
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
			texture = "role/217420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/217420_xp",
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
