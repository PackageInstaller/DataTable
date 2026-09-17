local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 28,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_attack",
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
	filename = "219920_effect",
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
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 5,
				id = 219910010
			},
			{
				frame = 6,
				id = 219910011
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
	totalframe = 54,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 10,
			sound = {
				"21000_skill",
				0.6
			}
		},
		{
			frame = 30,
			id = 219920010
		},
		{
			frame = 32,
			id = 219920010
		},
		{
			frame = 36,
			id = 219920010
		},
		{
			frame = 43,
			id = 219920010
		},
		{
			frame = 49,
			id = 219920010
		},
		{
			frame = 50,
			id = 219920011
		},
		{
			frame = 51,
			id = 219920012
		},
		{
			frame = 52,
			id = 219920013
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
	totalframe = 131,
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
			frame = 69,
			id = 219930010
		},
		{
			frame = 78,
			id = 219930010
		},
		{
			frame = 80,
			id = 219930010
		},
		{
			frame = 87,
			id = 219930010
		},
		{
			frame = 90,
			id = 219930011
		},
		{
			id = 219930012,
			behitted = "hitdown",
			frame = 110
		},
		{
			frame = 130,
			id = 219930013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "219920_bg",
	totalframe = 131,
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
			texture = "role/219920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/219920_xp",
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
