local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 34,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
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
		totalframe = 51,
		animation = "skill",
		exe_tbl = {
			{
				id = 51820001,
				frame = 35,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "skill-attack",
						name = "52000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
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
		totalframe = 96,
		animation = "xp",
		exe_tbl = {
			{
				frame = 68,
				id = 52030001
			},
			{
				frame = 75,
				id = 52030001
			},
			{
				frame = 82,
				id = 52030001
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 400,
	offsetZ = 1,
	filename = "52000_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				id = 52010001,
				frame = 3,
				effect = {
					{
						ani = "g_attack",
						name = "attack_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
