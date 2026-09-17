local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10087121,
				frame = 17
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				id = 10087131,
				behitted = "hitdown",
				frame = 16
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	usexp = {
		totalframe = 66,
		animation = "xp",
		exe_tbl = {
			{
				frame = 29,
				bullet = "xp"
			}
		}
	}
}

var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100871_effect",
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
		totalframe = 12,
		animation = "xp",
		exe_tbl = {
			{
				id = 10087161,
				behitted = "hitdown",
				frame = 1,
				forceY = {
					{
						speed = 400
					}
				}
			}
		}
	}
}

return var_0_0
