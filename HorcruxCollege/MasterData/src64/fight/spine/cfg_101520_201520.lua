local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 40,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26720_attack",
					0.6
				}
			},
			{
				frame = 20,
				bullet = "attack",
				effect = {
					{
						ani = "attack1",
						name = "101520_201520_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "101520_201520_effect",
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
		totalframe = 17,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 201510010
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
				"25320_skill",
				1
			}
		},
		{
			frame = 37,
			id = 201520011
		},
		{
			frame = 20,
			bullet = "attack",
			effect = {
				{
					ani = "skill",
					name = "101520_201520_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0.5,
					object = "target"
				}
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "101520_201520_effect",
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
		totalframe = 17,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 201520010
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
var_0_0.usexp = {
	totalframe = 80,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"203120_xp",
				1
			}
		},
		{
			frame = 1,
			id = 201530011
		},
		{
			behitted = "hitdown",
			id = 201530010,
			frame = 65,
			effect = {
				{
					ani = "skill",
					name = "101520_201520_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			},
			shake = {
				x = 6,
				y = 6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 0,
	bgfilescale = 1,
	bgfile = "201520_bg",
	totalframe = 70,
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktarget = "openent"
	},
	inserteffect = {
		{
			texture = "role/201520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/201520_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 5,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 25,
				startframe = 5
			},
			{
				scale = 0.9,
				totalframe = 30,
				startframe = 30
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 25,
				startframe = 30,
				time = 1
			}
		}
	}
}

return var_0_0
