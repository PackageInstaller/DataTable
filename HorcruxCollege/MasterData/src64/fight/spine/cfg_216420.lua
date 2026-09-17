local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 25,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 216410010,
				frame = 13
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 216410010,
				frame = 11
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 17,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 18,
				id = 216420010
			},
			{
				frame = 21,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 22,
				id = 216420010
			},
			{
				frame = 25,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 26,
				id = 216420010
			},
			{
				frame = 29,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 30,
				id = 216420010
			},
			{
				frame = 33,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 34,
				id = 216420010
			},
			{
				frame = 36,
				id = 216420010
			}
		}
	},
	usexp = {
		totalframe = 83,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 216430010,
				frame = 31,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 53,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 54,
				id = 216430011
			},
			{
				frame = 57,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 58,
				id = 216430011
			},
			{
				frame = 60,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 61,
				id = 216430011
			},
			{
				frame = 63,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 64,
				id = 216430011
			},
			{
				frame = 66,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 67,
				id = 216430011
			},
			{
				frame = 71,
				id = 216430012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 83,
	bgfile = "216420_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/216420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/216420_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 250,
				time = 0.5,
				distanceY = 0,
				totalframe = 53,
				startframe = 30
			}
		}
	}
}

return var_0_0
