local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack",
				sound = {
					"20400_attack",
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
		animation = "skill1",
		exe_tbl = {
			{
				id = 20420001,
				frame = 20,
				sound = {
					"20400_skill1",
					0.6
				}
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
		animation = "skill1",
		exe_tbl = {
			{
				id = 20420101,
				frame = 20,
				sound = {
					"20400_skill1",
					0.6
				}
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
		animation = "skill1",
		exe_tbl = {
			{
				id = 20420201,
				frame = 20,
				sound = {
					"20400_skill1",
					0.6
				}
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
		animation = "skill1",
		exe_tbl = {
			{
				id = 20420301,
				frame = 20,
				sound = {
					"20400_skill1",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 78,
		xpeffect = "xp_effect",
		animation = "xp2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20400_xp",
					0.6
				}
			},
			{
				behitted = "hit",
				id = 20433001,
				frame = 45,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				},
				shake = {
					x = 20,
					y = 0
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 77,
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
			texture = "role/20403.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 44,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 24,
				startframe = 36
			}
		},
		move = {
			{
				distance = 280,
				totalframe = 24,
				startframe = 36,
				time = 0.1
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
	filename = "20400_effect",
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
		totalframe = 13,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 20410001,
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

return var_0_0
