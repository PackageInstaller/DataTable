local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
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
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				frame = 19,
				bullet = "skill",
				shake = {
					x = 4,
					y = 4
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
				frame = 31,
				bullet = "xp",
				sound = "21600_attack"
			},
			{
				frame = 43,
				bullet = "xp",
				sound = "21600_attack"
			},
			{
				frame = 55,
				bullet = "xp",
				sound = "21600_attack"
			},
			{
				frame = 67,
				bullet = "xp",
				sound = "21600_attack"
			},
			{
				frame = 79,
				bullet = "xp",
				sound = "21600_attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "35301_effect",
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
		totalframe = 6,
		animation = "attact",
		exe_tbl = {
			{
				frame = 1,
				id = 35310001
			}
		}
	}
}
var_0_0.extra.skill = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "35302_effect",
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
		totalframe = 16,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 35320001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 250,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "35301_effect",
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
		totalframe = 21,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 35330001,
				frame = 1,
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	}
}

return var_0_0
