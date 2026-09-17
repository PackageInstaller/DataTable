local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"202820_attack",
					0.6
				}
			},
			{
				frame = 6,
				bullet = "attack_1"
			}
		}
	}
}

var_0_0.extra.attack_1 = {
	movingani = "run",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "214020_effect",
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
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 214010010
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
	totalframe = 30,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28820_skill",
				0.6
			}
		},
		{
			frame = 10,
			id = 214020010
		},
		{
			frame = 15,
			id = 214020011
		},
		{
			frame = 20,
			id = 214020011
		},
		{
			frame = 25,
			id = 214020011
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
	totalframe = 60,
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
			frame = 30,
			id = 214030010
		},
		{
			frame = 32,
			id = 214030011
		},
		{
			frame = 34,
			id = 214030011
		},
		{
			frame = 36,
			id = 214030011
		},
		{
			frame = 40,
			id = 214030012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "214020_bg",
	totalframe = 60,
	locktarget = {
		locktargetpool = "teammate",
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
			texture = "role/214020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/214020_xp",
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
