local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 36,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21630-attack",
					0.6
				}
			},
			{
				frame = 22,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 36,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21630-attack",
					0.6
				}
			},
			{
				frame = 22,
				bullet = "attack2"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 480,
	offsetZ = 1,
	filename = "11610_21630_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				id = 27010001,
				frame = 1
			},
			{
				id = 27010003,
				frame = 2
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run2",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 480,
	offsetZ = 1,
	filename = "11610_21630_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 2.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack2",
		exe_tbl = {
			{
				id = 27010002,
				frame = 1
			},
			{
				id = 27010003,
				frame = 2
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run2",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "11610_21630_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 16,
		animation = "skill-attck",
		exe_tbl = {
			{
				id = 27020001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "11610_21630_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 16,
		animation = "skill-attck",
		exe_tbl = {
			{
				id = 27020001,
				frame = 1
			},
			{
				frame = 2,
				id = 27020002
			}
		}
	}
}
var_0_0.extra.skill3 = {
	movingani = "run",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "11610_21630_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 16,
		animation = "skill-attck",
		exe_tbl = {
			{
				id = 27020201,
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
	totalframe = 48,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21630-skill",
				0.6
			}
		},
		{
			frame = 24,
			bullet = "skill1"
		},
		{
			frame = 29,
			bullet = "skill1"
		},
		{
			frame = 33,
			bullet = "skill1"
		},
		{
			frame = 37,
			bullet = "skill2"
		}
	}
}
var_0_0.useskill1_1 = {
	totalframe = 48,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21630-skill",
				0.6
			}
		},
		{
			frame = 24,
			bullet = "attack"
		},
		{
			frame = 29,
			bullet = "attack2"
		},
		{
			frame = 33,
			bullet = "attack"
		},
		{
			frame = 37,
			bullet = "attack2"
		}
	}
}
var_0_0.useskill1_2 = {
	totalframe = 48,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21630-skill",
				0.6
			}
		},
		{
			id = 27020201,
			frame = 24,
			bullet = "skill3"
		},
		{
			id = 27020201,
			frame = 29,
			bullet = "skill3"
		},
		{
			id = 27020201,
			frame = 33,
			bullet = "skill3"
		},
		{
			id = 27020201,
			frame = 37,
			bullet = "skill3"
		}
	}
}
var_0_0.useskill1_3 = {
	totalframe = 48,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21630-skill",
				0.6
			}
		},
		{
			frame = 24,
			id = 27020301
		},
		{
			frame = 29,
			id = 27020301
		},
		{
			frame = 33,
			id = 27020301
		},
		{
			frame = 37,
			id = 27020301
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = false,
	xpeffect = "xp_effect",
	totalframe = 93,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21630-xp",
				0.6
			}
		},
		{
			frame = 35,
			id = 27030001
		},
		{
			frame = 45,
			id = 27030001
		},
		{
			frame = 55,
			id = 27030001
		},
		{
			frame = 65,
			id = 27030001
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	totalframe = 93,
	bgfile = "marry_bg",
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
	},
	inserteffect = {
		{
			texture = "role/23820.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21630_xp",
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
	}
}

return var_0_0
