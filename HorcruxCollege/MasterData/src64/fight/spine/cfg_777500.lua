local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 18,
				bullet = "attack",
				sound = {
					"fire",
					0.4
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "777100_effect",
	initpos = {
		offsetY = 1.25,
		offsetX = 1.6,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 60110001
			}
		}
	}
}

return var_0_0
