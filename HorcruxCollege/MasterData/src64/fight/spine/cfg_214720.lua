local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
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
				bullet = "attack1"
			},
			{
				frame = 15,
				bullet = "attack1"
			},
			{
				frame = 20,
				bullet = "attack1"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "214720_effect",
	initpos = {
		offsetY = 1,
		offsetX = -0.1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 214710010,
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
	totalframe = 47,
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
			frame = 12,
			id = 214720010
		},
		{
			frame = 13,
			id = 214720011
		},
		{
			frame = 32,
			id = 214720012
		}
	}
}
var_0_0.usexp = {
	totalframe = 95,
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
			frame = 10,
			id = 214730010
		},
		{
			frame = 37,
			id = 214730011
		},
		{
			frame = 41,
			id = 214730011
		},
		{
			frame = 48,
			id = 214730011
		},
		{
			frame = 53,
			id = 214730011
		},
		{
			frame = 62,
			id = 214730011
		},
		{
			frame = 65,
			id = 214730012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
	bgfile = "214720_bg",
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
			texture = "role/214720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/214720_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
