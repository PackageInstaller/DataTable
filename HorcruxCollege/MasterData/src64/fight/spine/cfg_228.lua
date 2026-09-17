local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
				bullet = "attack",
				sound = {
					"nengliang",
					0.6
				}
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
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
		totalframe = 42,
		animation = "skill",
		exe_tbl = {
			{
				frame = 30,
				bullet = "skill1_1",
				sound = {
					"nengliang",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "skill1_2",
				sound = {
					"nengliang",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "skill1_3",
				sound = {
					"nengliang",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 91,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 1,
				sound = "xp"
			},
			{
				frame = 50,
				bullet = "xp",
				sound = {
					"nengliang",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "44000_bg",
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
	inserteffect = {
		{
			texture = "role/22820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	bgaction = {
		{
			param = 99,
			startframe = 0,
			action = "setZOrder"
		},
		{
			param = 0,
			startframe = 53,
			action = "setZOrder"
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 64,
			timescale = 0.15
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				intime = 0.2,
				anchory = 250,
				outtime = 0.1,
				totalframe = 50,
				startframe = 0
			},
			{
				scale = 0.9,
				intime = 0.1,
				anchory = 250,
				outtime = 0.2,
				totalframe = 10,
				startframe = 50
			},
			{
				scale = 1.2,
				intime = 0.05,
				anchory = 250,
				outtime = 0.2,
				totalframe = 16,
				startframe = 60
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 38,
				startframe = 52,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 91,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	animation = "xp2",
	exe_tbl = {
		{
			frame = 1,
			sound = "xp"
		},
		{
			frame = 50,
			bullet = "xp1",
			sound = {
				"nengliang",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 90,
	bgfile = "22800_bg",
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
	inserteffect = {
		{
			texture = "role/22820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	bgaction = {
		{
			param = 99,
			startframe = 0,
			action = "setZOrder"
		},
		{
			param = 0,
			startframe = 53,
			action = "setZOrder"
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 64,
			timescale = 0.15
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				intime = 0.2,
				anchory = 250,
				outtime = 0.1,
				totalframe = 50,
				startframe = 0
			},
			{
				scale = 0.9,
				intime = 0.1,
				anchory = 250,
				outtime = 0.2,
				totalframe = 10,
				startframe = 50
			},
			{
				scale = 1.2,
				intime = 0.05,
				anchory = 250,
				outtime = 0.2,
				totalframe = 16,
				startframe = 60
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 38,
				startframe = 52,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "attack_run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "22800_effect",
	initpos = {
		offsetY = 0.55,
		offsetX = 0.55,
		object = "self"
	},
	finalpos = {
		offsetY = 0.55,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22810001
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "lockdirection",
	speed = 1000,
	offsetZ = 1,
	filename = "22800_effect",
	initpos = {
		offsetY = 0.55,
		offsetX = 0.9,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "once",
		direction = 1
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820001,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "lockdirection",
	speed = 1000,
	offsetZ = 1,
	filename = "22800_effect",
	initpos = {
		offsetY = 1.1,
		offsetX = -0.2,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "once",
		direction = 1
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820001,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "lockdirection",
	speed = 1000,
	offsetZ = 1,
	filename = "22800_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = -1.1,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "once",
		direction = 1
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820001,
				force = {
					{
						time = 0.2,
						shakeutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktime",
	speed = 1200,
	offsetZ = 1,
	filename = "22800_effect",
	initpos = {
		offsetY = 1.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		time = 0.1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 24,
		animation = "xp_attack",
		exe_tbl = {
			{
				frame = 3,
				id = 22830001
			}
		}
	}
}
var_0_0.extra.xp1 = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktime",
	speed = 1200,
	offsetZ = 100,
	filename = "22800_effect",
	initpos = {
		offsetY = 1.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		time = 0.1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 24,
		animation = "xp_attack",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 3,
				id = 22850001,
				shake = {
					x = 0,
					y = 10
				},
				sound = {
					"fire2",
					0.6
				}
			}
		}
	}
}

return var_0_0
