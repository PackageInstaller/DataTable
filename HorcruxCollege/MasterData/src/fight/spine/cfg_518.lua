local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				frame = 20,
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
		totalframe = 59,
		animation = "skill",
		exe_tbl = {
			{
				id = 51820001,
				frame = 48,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "y_attack",
						name = "attack_effect",
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
		totalframe = 100,
		animation = "xp",
		exe_tbl = {
			{
				frame = 68,
				id = 51830001,
				effect = {
					{
						ani = "y_attack",
						name = "attack_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 78,
				id = 51830001,
				effect = {
					{
						ani = "y_attack",
						name = "attack_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 88,
				id = 51830001,
				effect = {
					{
						ani = "y_attack",
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

var_0_0.extra.attack = {
	movingani = "attack",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 400,
	offsetZ = 1,
	filename = "51800_effect",
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
		totalframe = 13,
		animation = "attack",
		exe_tbl = {
			{
				id = 51810001,
				frame = 3,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 20,
						object = "target"
					}
				},
				effect = {
					{
						ani = "y_attack",
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
