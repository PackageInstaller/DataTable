local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				bullet = "attack",
				sound = {
					"huigunzi",
					0.6
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
		lock_screen = {
			startframe = 0,
			lastframe = 25
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.6
				}
			},
			{
				frame = 27,
				id = 20930001,
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
					"dida",
					0.6
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
	filename = "50500_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 4,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 20910001,
				sound = {
					"boom",
					0.6
				}
			}
		}
	}
}

return var_0_0
