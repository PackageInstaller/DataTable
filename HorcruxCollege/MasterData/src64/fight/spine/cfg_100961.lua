local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = ">=",
				method = "random",
				param = {
					num = 8,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 18,
				bullet = "attack1"
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack2"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100961_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10096121,
				frame = 10,
				forceY = {
					{
						speed = 800
					}
				}
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100961_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10096122,
				frame = 10
			}
		}
	}
}

return var_0_0
