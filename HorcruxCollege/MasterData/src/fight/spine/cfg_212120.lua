local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 16,
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
	filename = "212120_effect",
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
		totalframe = 5,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 212110010
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 30,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 4,
			sound = {
				"202420_atk",
				0.6
			}
		},
		{
			frame = 16,
			bullet = "attack"
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
				"240_skill",
				0.6
			}
		},
		{
			frame = 36,
			id = 212120010
		},
		{
			id = 212120011,
			behitted = "hitdown",
			frame = 40
		},
		{
			frame = 41,
			id = 212120012
		},
		{
			frame = 42,
			id = 212120013
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
	totalframe = 100,
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
			frame = 66,
			id = 212130010
		},
		{
			frame = 68,
			id = 212130010
		},
		{
			frame = 70,
			id = 212130010
		},
		{
			frame = 72,
			id = 212130010
		},
		{
			frame = 76,
			id = 212130011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "212120_bg",
	totalframe = 100,
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
			texture = "role/212120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/212120_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 230,
				totalframe = 40,
				startframe = 45,
				time = 1
			}
		}
	}
}

return var_0_0
