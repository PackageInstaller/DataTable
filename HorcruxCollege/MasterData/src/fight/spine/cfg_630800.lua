local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "attack_run",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "630800_effect",
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
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 63080021
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
	totalframe = 30,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 16,
			id = 63080031
		},
		{
			frame = 20,
			id = 63080031
		},
		{
			frame = 25,
			id = 63080031
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
	totalframe = 30,
	turnbacklimit = true,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 1,
			sound = "100601_skill2"
		},
		{
			frame = 22,
			id = 63080041
		},
		{
			frame = 23,
			id = 63080042
		}
	}
}

return var_0_0
