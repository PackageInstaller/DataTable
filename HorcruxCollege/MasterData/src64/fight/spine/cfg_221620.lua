local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 34,
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
				frame = 21,
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
	filename = "221620_effect",
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
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				id = 221610010
			},
			{
				frame = 9,
				id = 221610011
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
				"20120-skill",
				0.6
			}
		},
		{
			frame = 18,
			id = 221620010
		},
		{
			frame = 30,
			id = 221620010
		},
		{
			frame = 32,
			id = 221620011
		},
		{
			frame = 35,
			id = 221620012
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
	totalframe = 129,
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
			frame = 60,
			id = 221630010
		},
		{
			frame = 70,
			id = 221630011
		},
		{
			frame = 105,
			id = 221630012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "221620_bg",
	totalframe = 129,
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
			texture = "role/221620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/221620_xp",
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
