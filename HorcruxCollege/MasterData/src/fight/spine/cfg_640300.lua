local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "attack1",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 700,
	offsetZ = 1,
	filename = "640300_effect",
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
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 64030021
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
	animation = "skill1",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 24,
			id = 64030031
		},
		{
			frame = 27,
			id = 64030031
		},
		{
			frame = 34,
			id = 64030031
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
	turnbacklimit = true,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 22,
			id = 64030041
		},
		{
			frame = 23,
			id = 64030042
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
	totalframe = 57,
	turnbacklimit = true,
	animation = "skill3",
	exe_tbl = {
		{
			frame = 1,
			sound = "100601_skill2"
		},
		{
			frame = 27,
			id = 64030051
		},
		{
			frame = 28,
			id = 64030052
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
	totalframe = 113,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "100481_xp"
		},
		{
			frame = 18,
			id = 64030061
		},
		{
			frame = 42,
			id = 64030061
		},
		{
			frame = 82,
			id = 64030061
		},
		{
			frame = 100,
			id = 64030061
		},
		{
			frame = 102,
			id = 64030061
		},
		{
			frame = 103,
			id = 64030062
		},
		{
			frame = 104,
			id = 64030063
		}
	}
}

return var_0_0
