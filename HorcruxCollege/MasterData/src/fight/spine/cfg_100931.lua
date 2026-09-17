local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
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
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100931_effect",
	initpos = {
		offsetY = 1.3,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				id = 10093121,
				frame = 4
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
			id = 10093131,
			frame = 30,
			effect = {
				{
					ani = "buff",
					name = "100931_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0.8,
					object = "self"
				}
			}
		}
	}
}

return var_0_0
