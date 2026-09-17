local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"23800_atk1",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "23840_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				id = 23810001,
				frame = 1,
				sound = {
					"23800_atk2",
					0.6
				},
				effect = {
					{
						ani = "attack",
						name = "23840_effect",
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
	totalframe = 50,
	animation = "skill",
	exe_tbl = {
		{
			frame = 19,
			sound = {
				"23800_skill",
				0.4
			}
		},
		{
			id = 23820001,
			frame = 34,
			effect = {
				{
					ani = "skill_attack",
					name = "23840_effect",
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
	totalframe = 50,
	animation = "skill",
	exe_tbl = {
		{
			frame = 10,
			sound = {
				"23800_skill",
				0.6
			}
		},
		{
			id = 23820101,
			frame = 34,
			effect = {
				{
					ani = "skill_attack",
					name = "23840_effect",
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
	totalframe = 50,
	animation = "skill",
	exe_tbl = {
		{
			frame = 10,
			sound = {
				"23800_skill",
				0.6
			}
		},
		{
			id = 23820201,
			frame = 34,
			effect = {
				{
					ani = "skill_attack",
					name = "23840_effect",
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
	totalframe = 50,
	animation = "skill",
	exe_tbl = {
		{
			frame = 10,
			sound = {
				"23800_skill",
				0.6
			}
		},
		{
			id = 23820301,
			frame = 34,
			effect = {
				{
					ani = "skill_attack",
					name = "23840_effect",
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
	totalframe = 106,
	animation = "xp",
	exe_tbl = {
		{
			frame = 28,
			sound = {
				"23800_xp",
				0.6
			}
		},
		{
			id = 23830001,
			frame = 52,
			effect = {
				{
					ani = "xp",
					name = "23840_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			id = 23830001,
			frame = 60,
			effect = {
				{
					ani = "xp",
					name = "23840_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			id = 23830001,
			frame = 68,
			effect = {
				{
					ani = "xp",
					name = "23840_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			id = 23830001,
			frame = 76,
			effect = {
				{
					ani = "xp",
					name = "23840_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			id = 23830001,
			frame = 84,
			effect = {
				{
					ani = "xp",
					name = "23840_effect",
					offsetZ = 1,
					offsetY = 0.4,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			frame = 90,
			id = 23830001
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	bgfilescale = 0.35,
	totalframe = 105,
	bgfile = "23840_bg",
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
	},
	inserteffect = {
		{
			texture = "role/23840.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23820_xp",
				1
			}
		}
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	camera = {
		zoom = {
			{
				startframe = 52,
				scale = 0.8,
				outtime = 0.3,
				totalframe = 43,
				intime = 0.1
			}
		}
	}
}

return var_0_0
