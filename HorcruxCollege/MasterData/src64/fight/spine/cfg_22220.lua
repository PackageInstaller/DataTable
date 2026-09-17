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
					"22220_attack",
					0.6
				}
			},
			{
				frame = 25,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "22220_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 22210010,
				frame = 7
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
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"22220_skill",
				0.6
			}
		},
		{
			id = 22220010,
			frame = 38,
			effect = {
				{
					ani = "skill",
					name = "22220_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 22220010,
			frame = 43,
			effect = {
				{
					ani = "skill",
					name = "22220_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 22220010,
			frame = 46,
			effect = {
				{
					ani = "skill",
					name = "22220_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
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
			frame = 1
		},
		{
			id = 22230010,
			behitted = "hitdown",
			frame = 54,
			shake = {
				x = 0,
				y = 20
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "22220_bg",
	locktarget = {
		mindistance = 300,
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
			texture = "role/22220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22220_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 37,
			timescale = 0.3
		},
		{
			totalframe = 5,
			startframe = 55,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {},
		move = {
			{
				pos = "target",
				totalframe = 25,
				startframe = 50,
				time = 0.3
			}
		}
	}
}

return var_0_0
