local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				frame = 18,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "650300_effect",
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
		totalframe = 22,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				id = 65030021
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
var_0_0.extra.skill = {
	movingani = "null",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "650300_effect",
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
		totalframe = 19,
		animation = "skill",
		exe_tbl = {
			{
				frame = 10,
				id = 65030021
			}
		}
	}
}
var_0_0.useskill1 = {
	totalframe = 47,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 25,
			bullet = "skill"
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
	totalframe = 50,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 30,
			id = 65030041
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
	totalframe = 60,
	turnbacklimit = true,
	animation = "skill3",
	exe_tbl = {
		{
			frame = 1,
			sound = "100601_skill2"
		},
		{
			frame = 42,
			id = 65030051
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
	totalframe = 105,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "100481_xp"
		},
		{
			frame = 67,
			id = 65030061
		},
		{
			frame = 72,
			id = 65030061
		},
		{
			frame = 77,
			id = 65030061
		},
		{
			frame = 82,
			id = 65030061
		},
		{
			frame = 87,
			id = 65030061
		},
		{
			frame = 90,
			id = 65030062
		}
	}
}

return var_0_0
