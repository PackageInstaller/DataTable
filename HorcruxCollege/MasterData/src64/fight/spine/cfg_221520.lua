local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 32,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_atk",
					0.6
				}
			},
			{
				frame = 18,
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
	filename = "221520_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = -0.25,
		object = "target"
	},
	attack = {
		totalframe = 32,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				id = 221510010
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
	filename = "221520_effect",
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 9,
				id = 221520010
			},
			{
				id = 221520011,
				behitted = "hitdown",
				frame = 10
			},
			{
				frame = 44,
				id = 221520012
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
	totalframe = 59,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20120-skill",
				0.6
			}
		},
		{
			frame = 18,
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
	totalframe = 119,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"260_xp",
				0.6
			}
		},
		{
			frame = 64,
			id = 221530010
		},
		{
			frame = 70,
			id = 221530010
		},
		{
			frame = 77,
			id = 221530010
		},
		{
			frame = 84,
			id = 221530010
		},
		{
			frame = 96,
			id = 221530010
		},
		{
			frame = 100,
			id = 221530011
		},
		{
			frame = 110,
			id = 221530012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "221520_bg",
	totalframe = 119,
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
			texture = "role/221520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/221520_xp",
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
