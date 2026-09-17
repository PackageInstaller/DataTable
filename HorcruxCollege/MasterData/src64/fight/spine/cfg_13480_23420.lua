local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 31,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23420_atk",
					0.6
				}
			},
			{
				frame = 14,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "23400_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "attact",
		exe_tbl = {
			{
				id = 23410001,
				frame = 1
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
var_0_0.skill1 = {
	{
		{
			method = "useSkill",
			param = "useskill1"
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
var_0_0.skill1_2 = {
	{
		{
			method = "useSkill",
			param = "useskill1_2"
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
var_0_0.useskill1 = {
	totalframe = 44,
	animation = "skill",
	exe_tbl = {
		{
			frame = 2,
			sound = {
				"23420_skill",
				0.6
			}
		},
		{
			id = 23420001,
			frame = 30,
			effect = {
				{
					ani = "skill_attact",
					name = "23400_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.useskill1_1 = {
	skillattackframe = 45,
	totalframe = 44,
	animation = "skill",
	exe_tbl = {
		{
			frame = 2,
			sound = {
				"23420_skill",
				0.6
			}
		},
		{
			id = 23420101,
			frame = 30,
			effect = {
				{
					ani = "skill_attact",
					name = "23400_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.useskill1_2 = {
	totalframe = 44,
	animation = "skill",
	exe_tbl = {
		{
			frame = 2,
			sound = {
				"23420_skill",
				0.6
			}
		},
		{
			id = 23420201,
			frame = 30,
			effect = {
				{
					ani = "skill_attact",
					name = "23400_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.useskill1_3 = {
	totalframe = 44,
	animation = "skill",
	exe_tbl = {
		{
			frame = 2,
			sound = {
				"23420_skill",
				0.6
			}
		},
		{
			id = 23420301,
			frame = 30,
			effect = {
				{
					ani = "skill_attact",
					name = "23400_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = false,
	xpeffect = "xp_effect",
	totalframe = 160,
	animation = "xp2",
	exe_tbl = {
		{
			frame = 2,
			sound = {
				"23420_xp",
				0.6
			}
		},
		{
			id = 23430001,
			behitted = "hitdown",
			frame = 110
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	bgfilescale = 0.2,
	bgfile = "13480_23400_1_bg",
	totalframe = 160,
	locktarget = {
		locktargetpool = "oponent"
	},
	show = {
		{
			action = "hide",
			startframe = 1,
			target = "target"
		},
		{
			action = "show",
			startframe = 100,
			target = "target"
		}
	},
	inserteffect = {
		{
			texture = "role/23420.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23420_xp",
				1
			}
		},
		{
			donotlock = true,
			isloop = false,
			file = "test/23400_dd",
			ani = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "xp2"
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				pos = "target",
				totalframe = 120,
				startframe = 40,
				time = 2.5
			}
		}
	}
}

return var_0_0
