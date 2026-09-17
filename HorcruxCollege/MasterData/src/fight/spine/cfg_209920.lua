local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack2"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack1"
			}
		}
	},
	attack2 = {
		totalframe = 32,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 209910011,
				frame = 20
			}
		}
	},
	attack1 = {
		totalframe = 28,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"202420_atk",
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
	speed = 600,
	offsetZ = 1,
	filename = "209920_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 209910010
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
				"203020_skill",
				0.6
			}
		},
		{
			frame = 22,
			id = 209920010
		},
		{
			frame = 29,
			id = 209920011
		},
		{
			frame = 30,
			id = 209920012
		}
	}
}
var_0_0.usexp = {
	totalframe = 94,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27420_xp",
				0.6
			}
		},
		{
			frame = 1,
			id = 209930010
		},
		{
			frame = 52,
			id = 209930011
		},
		{
			frame = 62,
			id = 209930011
		},
		{
			frame = 71,
			id = 209930011
		},
		{
			frame = 72,
			id = 209930012
		},
		{
			frame = 73,
			id = 209930013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 93,
	bgfile = "209920_bg",
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
			texture = "role/209920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/209920_xp",
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
		zoom = {
			{
				scale = 1.1,
				totalframe = 90,
				startframe = 2
			}
		},
		move = {}
	}
}

return var_0_0
