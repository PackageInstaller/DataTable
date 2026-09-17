local var_0_0 = {
	extra = {},
	attack1 = {
		totalframe = 10,
		nextani = true,
		animation = "attack_1",
		action_on_complete = {
			{
				method = "useSkill",
				param = "attack1_1"
			}
		}
	},
	attack1_1 = {
		totalframe = 25,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 14,
				bullet = "attack1_2"
			}
		}
	}
}

var_0_0.extra.attack1_2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100501_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10050121,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 10,
	nextani = true,
	animation = "attack_1",
	action_on_complete = {
		{
			method = "useSkill",
			param = "attack2_1"
		}
	}
}
var_0_0.attack2_1 = {
	totalframe = 25,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 14,
			bullet = "attack2_2"
		}
	}
}
var_0_0.extra.attack2_2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "100501_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10050171,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.attack3 = {
	totalframe = 10,
	nextani = true,
	animation = "attack_1",
	action_on_complete = {
		{
			method = "useSkill",
			param = "attack3_1"
		}
	}
}
var_0_0.attack3_1 = {
	totalframe = 25,
	animation = "attack3",
	exe_tbl = {
		{
			frame = 9,
			bullet = "attack3_2"
		}
	}
}
var_0_0.extra.attack3_2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "100501_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10050181,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -200,
						object = "self"
					}
				}
			}
		}
	}
}
var_0_0.attack4 = {
	totalframe = 10,
	nextani = true,
	animation = "attack_1",
	action_on_complete = {
		{
			method = "useSkill",
			param = "attack4_1"
		}
	}
}
var_0_0.attack4_1 = {
	totalframe = 25,
	animation = "attack4",
	exe_tbl = {
		{
			id = 10050191,
			frame = 10,
			effect = {
				{
					ani = "skill",
					name = "100501_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.attack3_1 = {
	totalframe = 25,
	animation = "attack3",
	exe_tbl = {
		{
			frame = 9,
			bullet = "attack3_2"
		}
	}
}
var_0_0.extra.attack3_2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "100501_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10050181,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -200,
						object = "self"
					}
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
	totalframe = 45,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 18,
			bullet = "skill1_1"
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "100501_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				id = 10050181,
				behitted = "hitdown",
				frame = 1
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
	totalframe = 46,
	animation = "skill2",
	exe_tbl = {
		{
			id = 10050141,
			frame = 20,
			effect = {
				{
					ani = "skill",
					name = "100501_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			force = {
				{
					time = 0.2,
					shutdown = true,
					distance = 200,
					object = "target"
				}
			}
		}
	}
}
var_0_0.skill3 = {
	{
		{
			method = "useSkill",
			param = "useskill3"
		}
	}
}
var_0_0.useskill3 = {
	totalframe = 55,
	animation = "skill3",
	exe_tbl = {
		{
			id = 10050151,
			frame = 38,
			effect = {
				{
					ani = "skill",
					name = "100501_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "xp_begin"
		}
	}
}
var_0_0.xp_begin = {
	totalframe = 110,
	xpeffect = "xp_bg",
	animation = "xp",
	exe_tbl = {
		{
			frame = 68,
			id = 10050161
		},
		shake = {
			x = 0,
			t = 20
		}
	}
}
var_0_0.xpeffect = {}
var_0_0.xpeffect.xp_bg = {
	initpos = 0,
	focusoffset = 0,
	bgfilescale = 1,
	totalframe = 85,
	bgfile = "100501_bg",
	locktarget = {
		locktargetpool = "openent",
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "xp"
		}
	},
	camera = {
		zoom = {
			{
				startframe = 38,
				scale = 0.8,
				anchory = 0,
				outtime = 0.3,
				totalframe = 45,
				intime = 0.1
			}
		}
	}
}

return var_0_0
