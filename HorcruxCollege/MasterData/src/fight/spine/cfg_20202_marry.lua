local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 20210001,
				frame = 11,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				id = 20210001,
				frame = 11,
				sound = {
					"20200_attack",
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
		totalframe = 25,
		animation = "skill",
		exe_tbl = {
			{
				id = 20220001,
				frame = 9,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 20220001,
				frame = 18,
				sound = {
					"20200_attack",
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
		totalframe = 25,
		animation = "skill",
		exe_tbl = {
			{
				id = 20220101,
				frame = 9,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 20220101,
				frame = 18,
				sound = {
					"20200_attack",
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
		totalframe = 25,
		animation = "skill",
		exe_tbl = {
			{
				id = 20220201,
				frame = 9,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 20220201,
				frame = 18,
				sound = {
					"20200_attack",
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
		totalframe = 25,
		animation = "skill",
		exe_tbl = {
			{
				id = 20220301,
				frame = 9,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				id = 20220301,
				frame = 18,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
	bgfile = "marry_bg",
	locktarget = {
		locktarget = true
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
			texture = "role/20202.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20202_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 32,
				startframe = 38
			},
			{
				scale = 1.2,
				totalframe = 10,
				startframe = 74
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 50,
				startframe = 38,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = true,
	xpeffect = "xp_effect",
	totalframe = 97,
	animation = "xp",
	action_on_start = {
		{
			startframe = 36,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 3,
						posx = 80
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 20232001,
			frame = 39,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 40,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 45,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 49,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 50,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 58,
			sound = {
				"20200_xp1"
			}
		},
		{
			behitted = "hitdown",
			id = 20232002,
			frame = 76,
			shake = {
				x = 0,
				y = 6
			},
			sound = {
				"20200_xp2"
			}
		}
	}
}

return var_0_0
