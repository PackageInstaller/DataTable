local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 20,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 700,
	offsetZ = 1,
	filename = "640900_effect",
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
		totalframe = 9,
		animation = "hit",
		exe_tbl = {
			{
				frame = 9,
				id = 64090021
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
	totalframe = 46,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 22,
			id = 64090031
		},
		{
			frame = 25,
			id = 64090031
		},
		{
			frame = 30,
			id = 64090031
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
	totalframe = 46,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 25,
			id = 64090041
		},
		{
			frame = 26,
			id = 64090042
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
	totalframe = 50,
	turnbacklimit = true,
	animation = "skill3",
	exe_tbl = {
		{
			frame = 1,
			sound = "100601_skill2"
		},
		{
			id = 64090051,
			behitted = "hitdown",
			frame = 15
		},
		{
			frame = 45,
			id = 64090052
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
	totalframe = 92,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "100481_xp"
		},
		{
			frame = 30,
			id = 64090062
		},
		{
			id = 64090061,
			behitted = "hitdown",
			frame = 68
		}
	}
}

return var_0_0
