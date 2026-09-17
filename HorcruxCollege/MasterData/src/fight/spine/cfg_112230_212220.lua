local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 29,
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
				frame = 12,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 24,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 3,
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
	speed = 900,
	offsetZ = 1,
	filename = "112230_212220_effect",
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
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 212210010
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
			frame = 15,
			bullet = "skill1"
		},
		{
			frame = 16,
			id = 212220011
		},
		{
			frame = 35,
			bullet = "skill1"
		},
		{
			frame = 36,
			id = 212220012
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run_skill",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "112230_212220_effect",
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
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 212220010
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
	totalframe = 111,
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
			frame = 30,
			id = 212230010
		},
		{
			frame = 45,
			id = 212230010
		},
		{
			frame = 55,
			id = 212230010
		},
		{
			frame = 69,
			id = 212230010
		},
		{
			frame = 81,
			id = 212230010
		},
		{
			frame = 82,
			id = 212230011
		},
		{
			frame = 83,
			id = 212230012
		},
		{
			frame = 84,
			id = 212230013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "212220_bg",
	totalframe = 111,
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
			texture = "role/212220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/212220_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 100,
				totalframe = 67,
				startframe = 27,
				time = 1.5
			}
		}
	}
}

return var_0_0
