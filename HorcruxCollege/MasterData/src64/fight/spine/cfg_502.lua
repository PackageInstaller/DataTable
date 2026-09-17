local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"nengliang",
					0.3
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
		totalframe = 114,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.4
				}
			},
			{
				frame = 30,
				id = 50130001,
				shake = {
					x = 0,
					y = 2
				}
			},
			{
				frame = 50,
				id = 50110001,
				shake = {
					x = 0,
					y = 2
				}
			},
			{
				frame = 70,
				id = 50110001,
				shake = {
					x = 0,
					y = 2
				}
			},
			{
				frame = 90,
				id = 50110001,
				shake = {
					x = 0,
					y = 2
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
	filename = "50200_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 4,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 50210001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 20,
						object = "target"
					}
				},
				sound = {
					"ice",
					0.3
				}
			}
		}
	}
}

return var_0_0
