local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"22500_attack",
					0.8
				}
			},
			{
				frame = 13,
				bullet = "attack",
				effect = {
					{
						ani = "attack2",
						name = "103530_203520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "103530_203520_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 3,
				id = 203510010
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 30,
	animation = "attack",
	exe_tbl = {
		{
			frame = 4,
			sound = {
				"22500_attack",
				0.8
			}
		},
		{
			frame = 13,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "103530_203520_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 20,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				id = 203510011
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
	animation = "skill",
	exe_tbl = {
		{
			frame = 10,
			sound = {
				"22320_skill",
				0.6
			}
		},
		{
			id = 203520010,
			frame = 30,
			effect = {
				{
					ani = "skill",
					name = "103530_203520_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
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
	totalframe = 100,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"203520_xp",
				1
			}
		},
		{
			id = 203530010,
			frame = 26,
			effect = {
				{
					ani = "skill2",
					name = "103530_203520_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1.1,
	totalframe = 100,
	bgfile = "203520_bg",
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktargetpool = "teammate",
		locktarget = true
	},
	inserteffect = {
		{
			texture = "role/203520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/203520_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 8,
			startframe = 64,
			timescale = 0.6
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 20,
				startframe = 5
			},
			{
				scale = 0.9,
				totalframe = 65,
				startframe = 25
			}
		},
		move = {
			{
				pos = "self",
				time = 0.5,
				distance = 100,
				totalframe = 80,
				startframe = 5
			}
		}
	}
}

return var_0_0
