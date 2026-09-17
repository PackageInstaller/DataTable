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
					"202420_atk",
					0.6
				}
			},
			{
				frame = 10
			},
			{
				frame = 15,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "attack_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 450,
	offsetZ = 1,
	filename = "103880_203820_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				id = 203810010,
				frame = 6
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
	totalframe = 60,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"201020_skill",
				0.6
			}
		},
		{
			id = 203820011,
			frame = 20,
			effect = {
				{
					ani = "skill",
					name = "103880_203820_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 20,
			id = 203820010
		},
		{
			frame = 21,
			id = 203820012
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
				"201020_xp",
				0.6
			}
		},
		{
			id = 203830011,
			frame = 35,
			effect = {
				{
					ani = "skill",
					name = "103880_203820_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 40,
			id = 203830010
		},
		{
			frame = 45,
			id = 203830012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "203820_bg",
	totalframe = 60,
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
			texture = "role/203820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/203820_xp",
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
			totalframe = 60,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 60,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
