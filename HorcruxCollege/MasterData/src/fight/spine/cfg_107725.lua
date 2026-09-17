local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack2 = {
		totalframe = 26,
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
	},
	attack = {
		totalframe = 26,
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
	speed = 600,
	offsetZ = 1,
	filename = "207720_effect",
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
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 207710010
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
	totalframe = 49,
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
			frame = 17,
			id = 207720010
		},
		{
			frame = 33,
			id = 207720011
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
				"241_xp",
				0.6
			}
		},
		{
			frame = 74,
			id = 207730010
		},
		{
			frame = 96,
			id = 207730011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "207720_bg",
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
			texture = "role/207520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/207720_xp",
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
			totalframe = 96,
			intime = 0.2
		},
		move = {
			{
				distance = 140,
				totalframe = 96,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
