local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 9,
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
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 16,
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
	filename = "30400_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 30410001
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
	filename = "21100_effect",
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
		totalframe = 20,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 30430001
			}
		}
	}
}

return var_0_0
