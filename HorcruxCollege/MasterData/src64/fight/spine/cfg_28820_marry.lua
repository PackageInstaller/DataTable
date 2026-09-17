local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28820_attack",
					0.6
				}
			},
			{
				frame = 20,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run1",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "18810_28820_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack1",
		exe_tbl = {
			{
				id = 28810010,
				frame = 5
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 30,
	animation = "attack",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28820_attack",
				0.6
			}
		},
		{
			frame = 20,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run2",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "18810_28820_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack2",
		exe_tbl = {
			{
				id = 28810011,
				frame = 5
			}
		}
	}
}
var_0_0.attack3 = {
	totalframe = 30,
	animation = "attack",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"28820_attack",
				0.6
			}
		},
		{
			frame = 20,
			bullet = "attack3"
		}
	}
}
var_0_0.extra.attack3 = {
	movingani = "run2",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 640,
	offsetZ = 1,
	filename = "18810_28820_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "attack3",
		exe_tbl = {
			{
				id = 28810012,
				frame = 5
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
				"28820_skill",
				0.6
			}
		},
		{
			frame = 24,
			id = 28820010
		},
		{
			frame = 25,
			id = 28820011
		}
	}
}
var_0_0.usexp = {
	totalframe = 80,
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
			frame = 42,
			id = 28830010
		},
		{
			frame = 43,
			id = 28830011
		},
		{
			frame = 44,
			id = 28830012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 80,
	bgfile = "marry_bg",
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktargetpool = "self",
		locktarget = true
	},
	inserteffect = {
		{
			texture = "role/28820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/28820_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 37,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
