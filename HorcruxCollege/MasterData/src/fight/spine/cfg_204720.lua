local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 37,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 15,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack1",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 750,
	offsetZ = 1,
	filename = "204720_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack1",
		exe_tbl = {
			{
				id = 204710011,
				frame = 6
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 48,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"202420_atk",
				0.6
			}
		},
		{
			frame = 15,
			bullet = "attack2"
		},
		{
			frame = 20,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack2",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 750,
	offsetZ = 1,
	filename = "204720_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack2",
		exe_tbl = {
			{
				id = 204710010,
				frame = 6
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
	totalframe = 57,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"240_skill",
				0.6
			}
		},
		{
			frame = 35,
			id = 204720011
		},
		{
			frame = 40,
			id = 204720021
		},
		{
			frame = 45,
			id = 204720021
		}
	}
}
var_0_0.skill1_juexing = {
	{
		{
			method = "useSkill",
			param = "useskill1_juexing"
		}
	}
}
var_0_0.useskill1_juexing = {
	totalframe = 57,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"240_skill",
				0.6
			}
		},
		{
			frame = 35,
			id = 204720010
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp1"
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 86,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"241_xp",
				0.6
			}
		},
		{
			frame = 40,
			id = 204730011
		},
		{
			frame = 80,
			id = 204730031
		},
		{
			frame = 81,
			id = 204730031
		},
		{
			frame = 82,
			id = 204730031
		},
		{
			frame = 83,
			id = 204730031
		},
		{
			frame = 85,
			id = 204730031
		},
		{
			frame = 42,
			id = 204730011
		},
		{
			frame = 45,
			id = 204730011
		},
		{
			frame = 50,
			id = 204730011
		},
		{
			frame = 53,
			id = 204730011
		},
		{
			frame = 58,
			id = 204730011
		},
		{
			frame = 62,
			id = 204730011
		},
		{
			frame = 68,
			id = 204730011
		},
		{
			frame = 72,
			id = 204730011
		},
		{
			frame = 78,
			id = 204730011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "204720_bg",
	totalframe = 86,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/204720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/204720_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 0.8,
				anchory = 300,
				outtime = 0.1,
				totalframe = 60,
				intime = 0.3
			}
		},
		move = {
			{
				distance = 110,
				totalframe = 60,
				startframe = 0,
				time = 1.5
			}
		}
	}
}
var_0_0.xp_juexing = {
	{
		{
			method = "useSkill",
			param = "usexp1_juexing"
		}
	}
}
var_0_0.usexp1_juexing = {
	totalframe = 86,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"241_xp",
				0.6
			}
		},
		{
			frame = 40,
			id = 204730010
		},
		{
			frame = 42,
			id = 204730010
		},
		{
			frame = 45,
			id = 204730010
		},
		{
			frame = 50,
			id = 204730010
		},
		{
			frame = 53,
			id = 204730010
		},
		{
			frame = 58,
			id = 204730010
		},
		{
			frame = 62,
			id = 204730010
		},
		{
			frame = 68,
			id = 204730010
		},
		{
			frame = 72,
			id = 204730010
		},
		{
			frame = 78,
			id = 204730010
		}
	}
}

return var_0_0
