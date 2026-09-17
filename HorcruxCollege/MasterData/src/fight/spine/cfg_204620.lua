local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 10,
				id = 204610013
			},
			{
				frame = 15,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	speed = 450,
	maxdistance = 1500,
	offsetZ = 1,
	movingtype = "locktarget",
	filename = "204620_effect",
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
		animation = "attack1",
		exe_tbl = {
			{
				id = 204610010,
				frame = 6
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 30,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"202420_atk",
				0.6
			}
		},
		{
			frame = 1,
			id = 204610012
		},
		{
			frame = 15,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	speed = 450,
	maxdistance = 1500,
	offsetZ = 1,
	movingtype = "locktarget",
	filename = "204620_effect",
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
		animation = "attack2",
		exe_tbl = {
			{
				id = 204610011,
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
				"240_skill",
				0.6
			}
		},
		{
			frame = 40,
			id = 204620010
		},
		{
			frame = 40,
			id = 204620011
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
	action_on_start = {
		{
			startframe = 55,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = 500,
						frame = 3
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"241_xp",
				0.6
			}
		},
		{
			frame = 40,
			id = 204630010
		},
		{
			frame = 43,
			id = 204630010
		},
		{
			frame = 45,
			id = 204630010
		},
		{
			frame = 50,
			id = 204630011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "204620_bg",
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
			texture = "role/204620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/204620_xp",
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
