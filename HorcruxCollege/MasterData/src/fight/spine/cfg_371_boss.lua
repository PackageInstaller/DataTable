local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				bullet = "attack"
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				id = 37120001,
				frame = 28,
				shake = {
					x = 4,
					y = 4
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 300,
						object = "target"
					}
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
		totalframe = 85,
		animation = "xp",
		exe_tbl = {
			{
				id = 37130001,
				frame = 45,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				id = 37130001,
				frame = 56,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				id = 37130001,
				frame = 68,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				id = 37130001,
				frame = 70,
				shake = {
					x = 0,
					y = 8
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
	filename = "37100_effect",
	size = {
		width = 20,
		height = 40
	},
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
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				id = 37110001,
				frame = 3
			}
		}
	}
}

return var_0_0
