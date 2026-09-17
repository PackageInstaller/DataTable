local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28420_attack1",
					0.6
				}
			},
			{
				frame = 6,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "28420_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 3,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 28410010,
				frame = 7
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
				"28420_attack2",
				0.6
			}
		},
		{
			frame = 15,
			bullet = "attack2"
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
	totalframe = 35,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28420_skill",
				0.6
			}
		},
		{
			frame = 21,
			id = 28420010
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run3",
	maxdistance = 600,
	movingtype = "lockdirection",
	speed = 1000,
	offsetZ = 1,
	filename = "28420_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				id = 28410010,
				frame = 7
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 100,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28420_xp",
				0.6
			}
		},
		{
			id = 28430010,
			behitted = "hitdown",
			frame = 80,
			shake = {
				x = 0,
				y = 20
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "28420_BG",
	locktarget = {
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
			texture = "role/28420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/28420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 75,
			timescale = 0.3
		}
	},
	camera = {
		move = {
			{
				pos = "target",
				totalframe = 20,
				startframe = 70,
				time = 0.1
			}
		}
	}
}

return var_0_0
