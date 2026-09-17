local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20400_attack",
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
	movingani = "run",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "26320_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				id = 26320001,
				frame = 3
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
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
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26320_skill",
				0.6
			}
		},
		{
			frame = 23,
			id = 26330001
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = false,
	xpeffect = "xp_effect",
	totalframe = 87,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26320_xp",
				0.6
			}
		},
		{
			frame = 60,
			id = 26350001
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	bgfilescale = 1,
	totalframe = 87,
	bgfile = "26320_bg",
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
	},
	inserteffect = {
		{
			texture = "role/26320.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26320_xp",
				1
			}
		}
	},
	bgani = {
		{
			startframe = 0,
			ani = "bg"
		}
	},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 1.2,
				outtime = 0.3,
				totalframe = 30,
				intime = 0.1
			},
			{
				startframe = 31,
				scale = 1,
				outtime = 0.3,
				totalframe = 30,
				intime = 0.1
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 59,
				startframe = 0,
				time = 0.1
			},
			{
				pos = "target",
				totalframe = 24,
				startframe = 59,
				time = 0.2
			}
		}
	}
}

return var_0_0
