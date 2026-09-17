local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = ">=",
				method = "random",
				param = {
					num = 5,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack_1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack_2"
			}
		}
	},
	attack_1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "attack1"
			}
		}
	},
	attack_2 = {
		totalframe = 30,
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
				frame = 18,
				bullet = "attack1"
			}
		}
	},
	attack2 = {
		{
			{
				operator = ">=",
				method = "random",
				param = {
					num = 5,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack_3"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack_4"
			}
		}
	},
	attack_3 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "attack2"
			}
		}
	},
	attack_4 = {
		totalframe = 30,
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
				frame = 18,
				bullet = "attack2"
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 60,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202420_skill",
					0.6
				}
			},
			{
				frame = 20,
				id = 202420010
			},
			{
				frame = 30,
				id = 202420011
			}
		}
	},
	usexp = {
		totalframe = 105,
		xpeffect = "xp_effect",
		turnbacklimit = false,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202420_xp",
					0.6
				}
			},
			{
				id = 202430010,
				behitted = "hitdown",
				frame = 90
			},
			{
				id = 202430010,
				behitted = "hitdown",
				frame = 95
			},
			{
				id = 202430010,
				behitted = "hitdown",
				frame = 100
			},
			{
				id = 202430010,
				behitted = "hitdown",
				frame = 105
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 105,
	bgfile = "202420_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "animation"
		}
	},
	inserteffect = {
		{
			texture = "role/202420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/202420_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 15,
			startframe = 85,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 25,
				startframe = 80
			}
		},
		move = {
			{
				distance = 220,
				totalframe = 15,
				startframe = 90,
				time = 0.4
			}
		}
	}
}
var_0_0.extra.attack1 = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "102450_202420_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 1.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				id = 202410010,
				frame = 6
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "102450_202420_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 1.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				id = 202410011,
				frame = 6
			}
		}
	}
}

return var_0_0
