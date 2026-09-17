local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 40,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"23120_attack",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "23130_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 23110010
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
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20600_skill",
				0.6
			}
		},
		{
			id = 23120010,
			frame = 35,
			effect = {
				{
					ani = "skill",
					name = "23130_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			}
		},
		{
			frame = 36,
			id = 23120011
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
			frame = 30,
			sound = {
				"23120_xp1",
				0.6
			}
		},
		{
			frame = 70,
			id = 23130010
		},
		{
			frame = 71,
			id = 23130011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "23130_bg",
	totalframe = 95,
	locktarget = {
		locktargetpool = "teammate",
		locktarget = true
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
			texture = "role/23130.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23120_xp",
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
			totalframe = 110,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 110,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
