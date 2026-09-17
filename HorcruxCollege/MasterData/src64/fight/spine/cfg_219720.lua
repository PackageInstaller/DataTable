local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 32,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20000_attack",
					0.6
				}
			},
			{
				frame = 22,
				id = 219710010
			}
		}
	},
	attack1 = {
		totalframe = 28,
		turnbacklimit = true,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20300_attack ",
					0.6
				}
			},
			{
				frame = 17,
				bullet = "attack1"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run_attack",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "219720_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				id = 219710011
			},
			{
				frame = 5,
				id = 219710012
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
	totalframe = 53,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20120_skill",
				0.6
			}
		},
		{
			frame = 20,
			id = 219720010
		},
		{
			frame = 25,
			id = 219720010
		},
		{
			frame = 30,
			id = 219720010
		},
		{
			frame = 35,
			id = 219720010
		},
		{
			frame = 36,
			id = 219720011
		},
		{
			frame = 45,
			id = 219720012
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
	totalframe = 134,
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
			frame = 75,
			id = 219730010
		},
		{
			frame = 80,
			id = 219730010
		},
		{
			frame = 85,
			id = 219730010
		},
		{
			frame = 90,
			id = 219730010
		},
		{
			frame = 109,
			id = 219730010
		},
		{
			frame = 110,
			id = 219730011
		},
		{
			frame = 111,
			id = 219730012
		},
		{
			frame = 130,
			id = 219730013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "219720_bg",
	totalframe = 134,
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
			texture = "role/219720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/219720_xp",
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
