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
					"arrow",
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
		totalframe = 35,
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
				frame = 27,
				id = 51930001,
				effect = {
					{
						ani = "xp",
						name = "heal_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"zhiliao",
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
	speed = 1200,
	offsetZ = 1,
	filename = "51900_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 2,
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
				id = 51910001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 20,
						object = "target"
					}
				},
				sound = {
					"arrowhit",
					0.3
				}
			}
		}
	}
}

return var_0_0
