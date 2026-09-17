local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
				id = 30510001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
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
		totalframe = 30,
		animation = "xp",
		exe_tbl = {
			{
				frame = 22,
				bullet = "xp"
			}
		}
	}
}

var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = -1,
	filename = "30500_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 2,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 30530001,
				shake = {
					x = 0,
					y = 4
				}
			}
		}
	}
}

return var_0_0
