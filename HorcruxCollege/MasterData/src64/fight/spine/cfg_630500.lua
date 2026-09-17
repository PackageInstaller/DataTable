local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
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
	filename = "630500_effect",
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
		totalframe = 7,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				id = 63050021
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
	totalframe = 40,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 19,
			id = 63050031
		},
		{
			frame = 29,
			id = 63050032
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
	totalframe = 49,
	turnbacklimit = true,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 1,
			sound = "100601_skill2"
		},
		{
			frame = 42,
			id = 63050041
		}
	}
}

return var_0_0
