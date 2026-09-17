local var_0_0 = {
	extra = {},
	attack1 = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 16,
				bullet = "attack1"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100721_effect",
	size = {
		width = 25,
		height = 25
	},
	initpos = {
		offsetY = 1,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10072121
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 25,
	animation = "attack",
	exe_tbl = {
		{
			frame = 16,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100721_effect",
	size = {
		width = 25,
		height = 25
	},
	initpos = {
		offsetY = 1,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10072122
			}
		}
	}
}
var_0_0.attack3 = {
	totalframe = 25,
	animation = "attack",
	exe_tbl = {
		{
			frame = 16,
			bullet = "attack3"
		}
	}
}
var_0_0.extra.attack3 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100721_effect",
	size = {
		width = 25,
		height = 25
	},
	initpos = {
		offsetY = 1,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10072123
			}
		}
	}
}
var_0_0.skill1 = {
	{
		{
			method = "useSkill",
			param = "useskill1"
		}
	}
}
var_0_0.useskill1 = {
	totalframe = 45,
	animation = "skill1",
	exe_tbl = {
		{
			id = 10072131,
			behitted = "hitdown",
			frame = 19,
			effect = {
				{
					ani = "skill1",
					name = "100721_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.skill2 = {
	{
		{
			method = "useSkill",
			param = "useskill2"
		}
	}
}
var_0_0.useskill2 = {
	totalframe = 48,
	animation = "skill2",
	exe_tbl = {
		{
			id = 10072141,
			frame = 18,
			force = {
				{
					shotdown = false,
					time = 0.5,
					distance = 300,
					object = "target"
				}
			},
			effect = {
				{
					ani = "skill2",
					name = "100721_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}

return var_0_0
