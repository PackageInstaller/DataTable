local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack"
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
		totalframe = 32,
		animation = "xp",
		exe_tbl = {
			{
				frame = 20,
				bullet = "xp",
				sound = {
					"zhiliao",
					0.4
				},
				effect = {
					{
						ani = "attack",
						name = "21100_effect2",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
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
	filename = "50500_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 2.75,
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
				id = 31110001
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "50700_effect2",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 31130001
			}
		}
	}
}

return var_0_0
