local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 25,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 2,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 9,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 2,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 8,
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
	filename = "210720_effect",
	initpos = {
		offsetY = 1.5,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				id = 210710010
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
				"240_skill",
				0.6
			}
		},
		{
			frame = 28,
			id = 210720010
		},
		{
			frame = 30,
			id = 210720011
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
	totalframe = 90,
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
			frame = 38,
			id = 210730010
		},
		{
			frame = 39,
			id = 210730011
		},
		{
			frame = 48,
			id = 210730010
		},
		{
			frame = 49,
			id = 210730011
		},
		{
			frame = 58,
			id = 210730010
		},
		{
			frame = 59,
			id = 210730011
		},
		{
			frame = 80,
			id = 210730012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "210720_bg",
	totalframe = 89,
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
			texture = "role/210720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/210720_xp",
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
				totalframe = 20,
				startframe = 25,
				time = 0.2
			}
		}
	}
}

return var_0_0
