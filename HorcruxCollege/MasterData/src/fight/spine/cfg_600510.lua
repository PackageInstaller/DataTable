local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60051021,
				frame = 17,
				effect = {
					{
						ani = "attack",
						name = "600510_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "self"
					}
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
		totalframe = 45,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 12,
				bullet = "skill1"
			}
		}
	}
}

var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 300,
	offsetZ = 1,
	filename = "600520_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 3,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 60051031
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
	totalframe = 40,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 10,
			bullet = "skill2"
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 400,
	movingtype = "lockdirection",
	speed = 666,
	offsetZ = 1,
	filename = "26100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				id = 60051041
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
	turnbacklimit = true,
	totalframe = 40,
	animation = "skill3",
	action_on_start = {
		{
			startframe = 13,
			action = {
				{
					method = "grab",
					param = {
						bonename = "role",
						finaloffset = cc.p(-200, 0)
					}
				}
			}
		},
		{
			startframe = 32,
			action = {
				{
					method = "releasegrab"
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 60051051,
			frame = 1,
			effect = {
				{
					ani = "attack",
					name = "600510_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0.8,
					object = "self"
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
	totalframe = 45,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 11,
			bullet = "xp"
		},
		{
			frame = 21,
			bullet = "xp1"
		},
		{
			frame = 32,
			bullet = "xp"
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "lockdirection",
	speed = 600,
	offsetZ = 1,
	filename = "600520_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 3,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 60051061
			}
		}
	}
}
var_0_0.extra.xp1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "lockdirection",
	speed = 600,
	offsetZ = 1,
	filename = "600520_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 3,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 60051061
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 45,
	bgfile = "40000_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 63,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.75,
				totalframe = 78,
				startframe = 15
			}
		},
		move = {
			{
				distance = 250,
				totalframe = 55,
				startframe = 33,
				time = 0.3
			}
		}
	}
}
var_0_0.xp_zhen = {
	{
		{
			method = "useSkill",
			param = "usexp_zhen"
		}
	}
}
var_0_0.usexp_zhen = {
	totalframe = 45,
	xpeffect = "xp_effect_zhen",
	animation = "xp",
	exe_tbl = {
		{
			frame = 11,
			bullet = "xp_zhen"
		},
		{
			frame = 21,
			bullet = "xp1_zhen"
		},
		{
			frame = 32,
			bullet = "xp_zhen"
		}
	}
}
var_0_0.extra.xp_zhen = {
	movingani = "skill1_run",
	maxdistance = 1000,
	movingtype = "lockdirection",
	speed = 600,
	offsetZ = 1,
	filename = "40000_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 3,
		animation = "skill1_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 60051062
			}
		}
	}
}
var_0_0.extra.xp1_zhen = {
	movingani = "skill1_run",
	maxdistance = 1000,
	movingtype = "lockdirection",
	speed = 600,
	offsetZ = 1,
	filename = "40000_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 3,
		animation = "skill1_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 60051062
			}
		}
	}
}
var_0_0.xpeffect.xp_effect_zhen = {
	totalframe = 45,
	bgfile = "40000_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 63,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.75,
				totalframe = 78,
				startframe = 15
			}
		},
		move = {
			{
				distance = 250,
				totalframe = 55,
				startframe = 33,
				time = 0.3
			}
		}
	}
}

return var_0_0
