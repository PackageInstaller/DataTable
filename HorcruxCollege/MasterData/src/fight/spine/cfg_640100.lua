local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				frame = 26,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "attack1",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "640100_effect",
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
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 64010021
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
	totalframe = 41,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 28,
			id = 64010031
		}
	}
}

return var_0_0
