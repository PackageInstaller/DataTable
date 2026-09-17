local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 16,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				bullet = "attack",
				sound = {
					"leidianduan",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "extra_attack",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "20320_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack_hit",
		exe_tbl = {
			{
				frame = 0,
				id = 20310001,
				sound = {
					"leidianduan",
					0.6
				}
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
	totalframe = 30,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 15,
			bullet = "skill1"
		}
	}
}
var_0_0.skill1_1 = {
	{
		{
			method = "useSkill",
			param = "useskill1_1"
		}
	}
}
var_0_0.useskill1_1 = {
	totalframe = 30,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 15,
			bullet = "skill1_1"
		}
	}
}
var_0_0.skill1_2 = {
	{
		{
			method = "useSkill",
			param = "useskill1_2"
		}
	}
}
var_0_0.useskill1_2 = {
	totalframe = 30,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 15,
			bullet = "skill1_2"
		}
	}
}
var_0_0.skill1_3 = {
	{
		{
			method = "useSkill",
			param = "useskill1_3"
		}
	}
}
var_0_0.useskill1_3 = {
	totalframe = 30,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 15,
			bullet = "skill1_3"
		}
	}
}
var_0_0.extra.skill1 = {
	speed = 3000,
	maxdistance = 1000,
	offsetZ = 1,
	movingtype = "locktarget",
	filename = "20320_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.05,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "extra_skill_1",
		exe_tbl = {
			{
				id = 20320001,
				frame = 0,
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	speed = 3000,
	maxdistance = 1000,
	offsetZ = 1,
	movingtype = "locktarget",
	filename = "20320_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.05,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "extra_skill_1",
		exe_tbl = {
			{
				id = 20320101,
				frame = 0,
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	speed = 3000,
	maxdistance = 1000,
	offsetZ = 1,
	movingtype = "locktarget",
	filename = "20320_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.05,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "extra_skill_1",
		exe_tbl = {
			{
				id = 20320201,
				frame = 0,
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	speed = 3000,
	maxdistance = 1000,
	offsetZ = 1,
	movingtype = "locktarget",
	filename = "20320_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.05,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "extra_skill_1",
		exe_tbl = {
			{
				id = 20320301,
				frame = 0,
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 30,
	turnbacklimit = true,
	nextani = true,
	animation = "xp_begin",
	lock_screen = {
		texture = "role/20320.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 23,
			bullet = "xp",
			sound = {
				"leidian",
				0.6
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_end"
		}
	}
}
var_0_0.xp_end = {
	totalframe = 10,
	turnbacklimit = true,
	animation = "xp_end"
}
var_0_0.extra.xp = {
	movingani = "extra_xp",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 3,
	filename = "20320_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 85,
		animation = "extra_xp_effect2",
		exe_tbl = {
			{
				id = 20350001,
				frame = 10,
				sound = {
					"leipixia",
					0.6
				}
			},
			{
				id = 20350001,
				frame = 40,
				sound = {
					"leipixia",
					0.6
				}
			},
			{
				id = 20350001,
				frame = 70,
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}

return var_0_0
