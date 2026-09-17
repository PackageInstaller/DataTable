local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 34,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				sound = {
					"240_attack",
					0.6
				}
			},
			{
				frame = 20,
				id = 219210010
			}
		}
	}
}

var_0_0.extra.skill1 = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "219220_effect",
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
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 2,
				id = 219220010
			},
			{
				frame = 5,
				id = 219220010
			},
			{
				frame = 10,
				id = 219220010
			},
			{
				frame = 17,
				id = 219220010
			},
			{
				frame = 24,
				id = 219220010
			},
			{
				frame = 27,
				id = 219220011
			},
			{
				frame = 29,
				id = 219220012
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
				"20600_skill",
				0.6
			}
		},
		{
			frame = 12,
			bullet = "skill1"
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
	totalframe = 97,
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
			frame = 20,
			id = 219230010
		},
		{
			frame = 71,
			id = 219230011
		},
		{
			frame = 72,
			id = 219230012
		},
		{
			frame = 75,
			id = 219230013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "219220_bg",
	totalframe = 97,
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
			texture = "role/219220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/219220_xp",
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
