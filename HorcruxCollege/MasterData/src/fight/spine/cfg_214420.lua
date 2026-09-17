local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"201020_attack",
					0.6
				}
			},
			{
				frame = 11,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "214420_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 1.7,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "attack",
		exe_tbl = {
			{
				id = 214410010,
				frame = 6
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
	totalframe = 50,
	turnbacklimit = false,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"222500_skill",
				1
			}
		},
		{
			frame = 19,
			id = 214420012
		},
		{
			frame = 20,
			id = 214420010
		},
		{
			frame = 25,
			id = 214420010
		},
		{
			frame = 30,
			id = 214420010
		},
		{
			frame = 35,
			id = 214420010
		},
		{
			frame = 36,
			id = 214420011
		}
	}
}
var_0_0.usexp = {
	totalframe = 100,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"22220_xp",
				2
			}
		},
		{
			frame = 54,
			id = 214430011
		},
		{
			frame = 55,
			id = 214430010
		},
		{
			frame = 62,
			id = 214430010
		},
		{
			frame = 69,
			id = 214430010
		},
		{
			frame = 76,
			id = 214430010
		},
		{
			frame = 83,
			id = 214430010
		},
		{
			frame = 90,
			id = 214430010
		},
		{
			frame = 92,
			id = 214430012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "214420_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/213920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213920_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 300,
				time = 0.2,
				distanceY = 0,
				totalframe = 44,
				startframe = 51
			}
		}
	}
}

return var_0_0
