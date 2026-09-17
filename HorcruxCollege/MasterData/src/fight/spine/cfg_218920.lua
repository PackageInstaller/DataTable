local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
				bullet = "attack",
				sound = {
					"20400_attack",
					0.6
				}
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
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"20400_skill1",
					0.6
				}
			},
			{
				id = 218920010,
				frame = 17
			},
			{
				id = 218920011,
				frame = 18
			},
			{
				id = 218920012,
				frame = 19
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	useskill1_1 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"20400_skill1",
					0.6
				}
			},
			{
				id = 218920010,
				frame = 17
			},
			{
				id = 218920011,
				frame = 18
			},
			{
				id = 218920012,
				frame = 19
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	useskill1_2 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"20400_skill1",
					0.6
				}
			},
			{
				id = 218920010,
				frame = 17
			},
			{
				id = 218920011,
				frame = 18
			},
			{
				id = 218920012,
				frame = 19
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1_3 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"20400_skill1",
					0.6
				}
			},
			{
				id = 218920010,
				frame = 17
			},
			{
				id = 218920011,
				frame = 18
			},
			{
				id = 218920012,
				frame = 19
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
	filename = "218920_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 1.75,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 218910010,
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
var_0_0.xp = {
	{
		{
			operator = "<=",
			method = "random",
			param = {
				num = 3,
				range = 9
			}
		},
		{
			method = "useSkill",
			param = "xp_begin1"
		}
	},
	{
		{
			operator = "<=",
			method = "random",
			param = {
				num = 3,
				range = 6
			}
		},
		{
			method = "useSkill",
			param = "xp_begin2"
		}
	},
	{
		{
			method = "useSkill",
			param = "xp_begin3"
		}
	}
}
var_0_0.xp_begin1 = {
	totalframe = 63,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	animation = "xp1",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20400_xp"
			}
		},
		{
			frame = 42,
			id = 218930010
		},
		{
			frame = 43,
			id = 218930010
		},
		{
			frame = 44,
			id = 218930010
		},
		{
			frame = 48,
			id = 218930010
		},
		{
			frame = 50,
			id = 218930011
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 62,
	bgfile = "218920_bg",
	locktarget = {
		mindistance = 150,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/218920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 35,
			timescale = 0.1
		}
	},
	camera = {
		move = {
			{
				distance = 150,
				totalframe = 23,
				startframe = 27,
				time = 0.3
			}
		}
	}
}
var_0_0.xp_begin2 = {
	totalframe = 63,
	xpeffect = "xp_effect2",
	turnbacklimit = true,
	animation = "xp2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20400_xp"
			}
		},
		{
			frame = 42,
			id = 218930010
		},
		{
			frame = 43,
			id = 218930010
		},
		{
			frame = 44,
			id = 218930010
		},
		{
			frame = 48,
			id = 218930010
		},
		{
			frame = 50,
			id = 218930011
		}
	}
}
var_0_0.xpeffect.xp_effect2 = {
	totalframe = 62,
	bgfile = "218920_bg",
	locktarget = {
		mindistance = 150,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/218920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 35,
			timescale = 0.1
		}
	},
	camera = {
		move = {
			{
				distance = 150,
				totalframe = 23,
				startframe = 27,
				time = 0.3
			}
		}
	}
}
var_0_0.xp_begin3 = {
	totalframe = 63,
	xpeffect = "xp_effect3",
	turnbacklimit = true,
	animation = "xp3",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20400_xp"
			}
		},
		{
			frame = 42,
			id = 218930010
		},
		{
			frame = 43,
			id = 218930010
		},
		{
			frame = 44,
			id = 218930010
		},
		{
			frame = 48,
			id = 218930010
		},
		{
			frame = 50,
			id = 218930011
		}
	}
}
var_0_0.xpeffect.xp_effect3 = {
	totalframe = 62,
	bgfile = "218920_bg",
	locktarget = {
		mindistance = 150,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/218920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 35,
			timescale = 0.1
		}
	},
	camera = {
		move = {
			{
				distance = 150,
				totalframe = 23,
				startframe = 27,
				time = 0.3
			}
		}
	}
}
var_0_0.xp1 = {
	{
		{
			operator = "<=",
			method = "random",
			param = {
				num = 3,
				range = 9
			}
		},
		{
			method = "useSkill",
			param = "xp_begin1_1"
		}
	},
	{
		{
			operator = "<=",
			method = "random",
			param = {
				num = 3,
				range = 6
			}
		},
		{
			method = "useSkill",
			param = "xp_begin1_2"
		}
	},
	{
		{
			method = "useSkill",
			param = "xp_begin1_3"
		}
	}
}
var_0_0.xp_begin1_1 = {
	totalframe = 63,
	xpeffect = "xp_effect1_1",
	turnbacklimit = true,
	animation = "xp1",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20400_xp"
			}
		},
		{
			frame = 42,
			id = 218930010
		},
		{
			frame = 43,
			id = 218930010
		},
		{
			frame = 44,
			id = 218930010
		},
		{
			frame = 48,
			id = 218930010
		},
		{
			frame = 50,
			id = 218930011
		}
	}
}
var_0_0.xpeffect.xp_effect1_1 = {
	totalframe = 62,
	bgfile = "218920_bg",
	locktarget = {
		mindistance = 150,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/218920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 35,
			timescale = 0.1
		}
	},
	camera = {
		move = {
			{
				distance = 150,
				totalframe = 23,
				startframe = 27,
				time = 0.3
			}
		}
	}
}
var_0_0.xp_begin1_2 = {
	totalframe = 63,
	xpeffect = "xp_effect1_2",
	turnbacklimit = true,
	animation = "xp2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20400_xp"
			}
		},
		{
			frame = 42,
			id = 218930010
		},
		{
			frame = 43,
			id = 218930010
		},
		{
			frame = 44,
			id = 218930010
		},
		{
			frame = 48,
			id = 218930010
		},
		{
			frame = 50,
			id = 218930011
		}
	}
}
var_0_0.xpeffect.xp_effect1_2 = {
	totalframe = 62,
	bgfile = "218920_bg",
	locktarget = {
		mindistance = 150,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/218920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 35,
			timescale = 0.1
		}
	},
	camera = {
		move = {
			{
				distance = 150,
				totalframe = 23,
				startframe = 27,
				time = 0.3
			}
		}
	}
}
var_0_0.xp_begin1_3 = {
	totalframe = 63,
	xpeffect = "xp_effect1_3",
	turnbacklimit = true,
	animation = "xp3",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20400_xp"
			}
		},
		{
			frame = 42,
			id = 218930010
		},
		{
			frame = 43,
			id = 218930010
		},
		{
			frame = 44,
			id = 218930010
		},
		{
			frame = 48,
			id = 218930010
		},
		{
			frame = 50,
			id = 218930011
		}
	}
}
var_0_0.xpeffect.xp_effect1_3 = {
	totalframe = 62,
	bgfile = "218920_bg",
	locktarget = {
		mindistance = 150,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/218920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 35,
			timescale = 0.1
		}
	},
	camera = {
		move = {
			{
				distance = 150,
				totalframe = 23,
				startframe = 27,
				time = 0.3
			}
		}
	}
}

return var_0_0
