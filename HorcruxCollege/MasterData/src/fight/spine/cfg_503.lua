local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				bullet = "attack",
				sound = {
					"jiguang",
					0.2
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
		totalframe = 37,
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
				frame = 25,
				id = 50330001,
				sound = {
					"jiguang",
					0.3
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "50500_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 50310001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 20,
						object = "target"
					}
				},
				sound = {
					"boom",
					0.3
				}
			}
		}
	}
}

return var_0_0
