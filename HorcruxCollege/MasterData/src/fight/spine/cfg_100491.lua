local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run-attack",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "100491_effect",
	size = {
		width = 25,
		height = 25
	},
	initpos = {
		offsetY = 2.4,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10049121
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
	totalframe = 50,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 29,
			bullet = "skill1"
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run-skill1",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100491_effect",
	initpos = {
		offsetY = 4,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = -0.01,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				id = 10049131
			}
		}
	}
}
var_0_0.skill2 = {
	{
		{
			method = "useSkill",
			param = "useskill2"
		}
	}
}
var_0_0.useskill2 = {
	totalframe = 54,
	animation = "skill2",
	exe_tbl = {
		{
			id = 10049141,
			frame = 28,
			effect = {
				{
					ani = "skill2",
					name = "100491_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.skill3 = {
	{
		{
			method = "useSkill",
			param = "useskill3"
		}
	}
}
var_0_0.useskill3 = {
	totalframe = 55,
	animation = "skill3",
	exe_tbl = {
		{
			id = 10049151,
			frame = 45,
			effect = {
				{
					ani = "buff",
					name = "100491_effect",
					offsetZ = 1,
					offsetY = 3,
					offsetX = 1,
					object = "self"
				}
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "xp_begin"
		}
	}
}
var_0_0.xp_begin = {
	totalframe = 85,
	xpeffect = "test",
	animation = "xp",
	exe_tbl = {
		{
			frame = 41,
			id = 10049161
		},
		shake = {
			x = 0,
			t = 10
		}
	}
}
var_0_0.xpeffect = {}
var_0_0.xpeffect.test = {
	focusoffset = 0,
	bgfilescale = 1,
	initpos = 0,
	bgfile = "100491_bg",
	totalframe = 64,
	locktarget = {
		locktargetpool = "openent",
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "xp"
		}
	},
	lockframe = {
		{
			totalframe = 8,
			startframe = 30,
			timescale = 0.8
		}
	},
	camera = {
		zoom = {
			{
				startframe = 38,
				scale = 0.8,
				anchory = 0,
				outtime = 0.3,
				totalframe = 15,
				intime = 0.1
			}
		},
		move = {
			{
				pos = "self",
				time = 0.5,
				distance = 200,
				totalframe = 8,
				startframe = 54
			}
		}
	}
}

return var_0_0
