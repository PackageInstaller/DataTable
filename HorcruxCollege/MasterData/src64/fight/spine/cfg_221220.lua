local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
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
				id = 221210010,
				frame = 18
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 221210010,
				frame = 14
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "skill_run",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "221220_effect",
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
		totalframe = 59,
		animation = "skill",
		exe_tbl = {
			{
				frame = 18,
				id = 221220010
			},
			{
				frame = 24,
				id = 221220010
			},
			{
				frame = 48,
				id = 221220010
			},
			{
				frame = 49,
				id = 221220011
			},
			{
				frame = 50,
				id = 221220012
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
	totalframe = 59,
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
			frame = 1,
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
	totalframe = 86,
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
			frame = 44,
			id = 221230010
		},
		{
			frame = 50,
			id = 221230010
		},
		{
			frame = 50,
			id = 221230010
		},
		{
			frame = 54,
			id = 221230010
		},
		{
			frame = 62,
			id = 221230010
		},
		{
			frame = 72,
			id = 221230011
		},
		{
			frame = 80,
			id = 221230012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "221220_bg",
	totalframe = 86,
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
			texture = "role/221220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/221220_xp",
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
