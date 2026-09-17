local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				bullet = "attack",
				sound = {
					"26620_attack",
					0.6
				}
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 18,
				bullet = "skill1",
				sound = {
					"26620_skill",
					0.6
				}
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill2 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 18,
				bullet = "skill2",
				sound = {
					"26620_skill",
					0.6
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	usexp = {
		totalframe = 60,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 5,
				sound = "26620_xp"
			},
			{
				frame = 37,
				bullet = "xp"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "217620_bg",
	locktarget = {
		locktargetpool = "all",
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
			texture = "role/217620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26620_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 20,
			timescale = 0.1
		}
	},
	camera = {
		move = {
			{
				distance = 110,
				totalframe = 65,
				startframe = 25,
				time = 0.2
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "attack",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "217620_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "hit",
		exe_tbl = {
			{
				id = 217610010,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run1",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "217620_effect",
	size = {
		width = 20,
		height = 20
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 55,
		animation = "skill1",
		exe_tbl = {
			{
				id = 217620010,
				frame = 5
			},
			{
				id = 217620011,
				frame = 6
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "run1",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "217620_effect",
	size = {
		width = 20,
		height = 20
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 55,
		animation = "skill2",
		exe_tbl = {
			{
				id = 217640010,
				frame = 5
			},
			{
				id = 217640011,
				frame = 6
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run2",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 700,
	offsetZ = 1,
	filename = "217620_effect",
	size = {
		width = 80,
		height = 80
	},
	initpos = {
		offsetY = 1,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 70,
		animation = "xp",
		exe_tbl = {
			{
				id = 217630010,
				frame = 10
			},
			{
				frame = 10,
				id = 217630011
			},
			{
				frame = 8,
				shake = {
					x = 4,
					y = 15
				}
			}
		}
	}
}

return var_0_0
