local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 14,
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
		totalframe = 43,
		animation = "skill",
		exe_tbl = {
			{
				frame = 22,
				bullet = "skill"
			},
			{
				frame = 26,
				bullet = "skill"
			},
			{
				frame = 30,
				bullet = "skill"
			},
			{
				frame = 34,
				bullet = "skill"
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
				frame = 28,
				bullet = "xp"
			},
			{
				frame = 32,
				bullet = "xp"
			},
			{
				frame = 36,
				bullet = "xp"
			},
			{
				frame = 40,
				bullet = "xp"
			},
			{
				frame = 44,
				bullet = "xp"
			},
			{
				frame = 48,
				bullet = "xp"
			},
			{
				frame = 52,
				bullet = "xp"
			},
			{
				frame = 56,
				bullet = "xp"
			},
			{
				frame = 60,
				bullet = "xp"
			},
			{
				frame = 64,
				bullet = "xp"
			},
			{
				frame = 68,
				bullet = "xp"
			},
			{
				frame = 72,
				bullet = "xp"
			},
			{
				frame = 76,
				bullet = "xp"
			},
			{
				frame = 80,
				bullet = "xp"
			},
			{
				frame = 84,
				bullet = "xp"
			},
			{
				frame = 88,
				bullet = "xp"
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
	filename = "37200_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				id = 37210001,
				frame = 3
			}
		}
	}
}
var_0_0.extra.skill = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "37200_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				id = 37220001,
				frame = 3
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "lockdirection",
	speed = 1500,
	offsetZ = 1,
	filename = "37200_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "once",
		direction = 1
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				id = 37210001,
				frame = 3
			}
		}
	}
}

return var_0_0
