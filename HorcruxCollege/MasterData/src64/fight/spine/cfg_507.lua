local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 14,
				bullet = "attack",
				sound = {
					"gun",
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
		totalframe = 50,
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
				frame = 35,
				bullet = "xp",
				sound = {
					"gun",
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
	filename = "21400_effect1",
	initpos = {
		offsetY = 0.45,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 50710001,
				sound = {
					"gun",
					0.3
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "20400_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				id = 50730001,
				sound = {
					"gun",
					0.4
				}
			}
		}
	}
}

return var_0_0
