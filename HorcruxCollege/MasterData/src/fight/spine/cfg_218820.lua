local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21100_attack",
					0.6
				}
			},
			{
				id = 218810010,
				frame = 14
			}
		}
	},
	attack2 = {
		totalframe = 40,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23320_atk",
					0.6
				}
			},
			{
				id = 218810011,
				frame = 25
			},
			{
				id = 218810012,
				frame = 26
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "skill_run",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 18,
	filename = "218820_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.05,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 18,
		animation = "skill",
		exe_tbl = {
			{
				frame = 9,
				id = 218820012
			},
			{
				frame = 10,
				id = 218820011
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
	totalframe = 26,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"260_skill1",
				0.6
			}
		},
		{
			frame = 16,
			id = 218820010
		},
		{
			frame = 26,
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
	totalframe = 95,
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
			id = 218830011
		},
		{
			frame = 31,
			id = 218830010
		},
		{
			frame = 40,
			id = 218830010
		},
		{
			frame = 48,
			id = 218830010
		},
		{
			frame = 50,
			id = 218830010
		},
		{
			frame = 57,
			id = 218830010
		},
		{
			frame = 66,
			id = 218830010
		},
		{
			frame = 70,
			id = 218830010
		},
		{
			id = 218830010,
			behitted = "hitdown",
			frame = 78
		},
		{
			frame = 94,
			id = 218830012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "218820_bg",
	totalframe = 95,
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
			texture = "role/218820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/218820_xp",
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
