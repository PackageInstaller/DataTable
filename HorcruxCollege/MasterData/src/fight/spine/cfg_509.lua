local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				bullet = "attack",
				sound = {
					"huiwu",
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
		totalframe = 30,
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
				frame = 12,
				bullet = "xp"
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
	filename = "50900_effect",
	initpos = {
		offsetY = 0.8,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 4,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 50910001,
				sound = {
					"horn_fire",
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
	filename = "heal_effect",
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
				id = 50930001,
				sound = {
					"zhiliao",
					0.4
				}
			}
		}
	}
}

return var_0_0
