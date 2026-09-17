local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 13,
				bullet = "attack_1"
			},
			{
				frame = 14,
				id = 212410011
			}
		}
	}
}

var_0_0.extra.attack_1 = {
	movingani = "attack_run",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "212420_effect",
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
		totalframe = 16,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 212410010
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
			frame = 31,
			bullet = "skill1"
		},
		{
			frame = 32,
			id = 212420012
		},
		{
			frame = 34,
			bullet = "skill1"
		},
		{
			frame = 35,
			id = 212420012
		},
		{
			frame = 37,
			bullet = "skill1"
		},
		{
			frame = 38,
			id = 212420012
		},
		{
			frame = 45,
			id = 212420011
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "attack_run",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "212420_effect",
	initpos = {
		offsetY = 1,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.75,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 16,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 212420010
			}
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
	totalframe = 85,
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
			frame = 55,
			id = 212430010
		},
		{
			frame = 57,
			id = 212430013
		},
		{
			frame = 59,
			id = 212430010
		},
		{
			frame = 61,
			id = 212430013
		},
		{
			frame = 63,
			id = 212430010
		},
		{
			frame = 65,
			id = 212430013
		},
		{
			frame = 67,
			id = 212430010
		},
		{
			frame = 69,
			id = 212430013
		},
		{
			frame = 71,
			id = 212430010
		},
		{
			frame = 73,
			id = 212430013
		},
		{
			frame = 74,
			id = 212430011
		},
		{
			frame = 75,
			id = 212430012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "212420_bg",
	totalframe = 85,
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
			texture = "role/212420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/212420_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 90,
				totalframe = 65,
				startframe = 20,
				time = 0.4
			}
		}
	}
}

return var_0_0
