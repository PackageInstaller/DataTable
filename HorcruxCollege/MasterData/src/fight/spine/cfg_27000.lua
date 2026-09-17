local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27020_attack",
					0.6
				}
			},
			{
				frame = 20,
				bullet = "attack"
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27020_skill",
					0.6
				}
			},
			{
				id = 30020001,
				frame = 24
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27020_skill",
					0.6
				}
			},
			{
				id = 30020001,
				frame = 24
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27020_skill",
					0.6
				}
			},
			{
				id = 30020001,
				frame = 24
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27020_skill",
					0.6
				}
			},
			{
				id = 30020001,
				frame = 24
			}
		}
	},
	usexp = {
		totalframe = 76,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27020_xp",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 30030001,
				frame = 58,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					{
						speed = 200,
						distance = 100,
						time = 0.1
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 74,
	bgfile = "27000_bg",
	locktarget = {
		mindistance = 240,
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
			texture = "role/21910.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/27000_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 43,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				startframe = 15,
				scale = 0.8,
				anchory = 0,
				outtime = 0.3,
				totalframe = 50,
				intime = 0.1
			}
		},
		move = {
			{
				pos = "target",
				distanceY = 0,
				distance = 100,
				time = 0.5,
				totalframe = 25,
				startframe = 45
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "27000_effect",
	initpos = {
		offsetY = -0.1,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		time = 0.2,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 16,
		animation = "attack",
		exe_tbl = {
			{
				frame = 5,
				id = 30010001
			}
		}
	}
}

return var_0_0
