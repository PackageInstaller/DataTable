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
					"leidianduan",
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420001,
				frame = 32,
				sound = {
					"leidianduan",
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420101,
				frame = 32,
				sound = {
					"leidianduan",
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420201,
				frame = 32,
				sound = {
					"leidianduan",
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420301,
				frame = 32,
				sound = {
					"leidianduan",
					0.6
				}
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
				frame = 60,
				id = 21450001,
				shake = {
					period = 2,
					time = 0.2,
					x = 10,
					y = 50
				},
				sound = {
					"leidian",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 75,
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
			texture = "role/21420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 60,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 28,
				startframe = 22
			},
			{
				scale = 0.8,
				totalframe = 15,
				startframe = 52
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 28,
				startframe = 22,
				time = 0.1
			},
			{
				distance = 240,
				totalframe = 15,
				startframe = 52,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "effect_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "21420_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 21410001,
				sound = {
					"leidianduan",
					0.6
				}
			}
		}
	}
}

return var_0_0
