local var_0_0 = {
	extra = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 10,
					range = 20
				}
			},
			{
				method = "useAttack",
				param = "attack1"
			}
		},
		{
			{
				method = "useAttack",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 37,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"25320_slave",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 37,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack1",
				sound = {
					"25320_slave",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "25320_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 5,
		offsetX = -2.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 25100099,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.attack1 = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "25320_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 5,
		offsetX = 2.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 25100099,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
