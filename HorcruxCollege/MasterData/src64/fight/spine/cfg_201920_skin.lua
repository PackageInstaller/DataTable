local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 8,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 0,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 18,
				id = 201910010
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 0,
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 15,
				id = 201910010
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
		skillattackframe = 45,
		totalframe = 40,
		exe_crash_by_frame = 1,
		exe_crash_type = "carry",
		animation = "skill",
		exe_crash_bound = 80,
		exe_type = "crash",
		turnbacklimit = true,
		action_on_start = {
			{
				startframe = 3,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 150,
							time = 0.2
						}
					}
				}
			},
			{
				startframe = 26,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -100,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201920_skill",
					0.6
				}
			},
			{
				id = 201920010,
				frame = 10,
				forceY = {
					{
						speed = 750
					}
				}
			},
			{
				id = 201920010,
				behitted = "hitdown",
				frame = 21
			},
			{
				frame = 28,
				id = 201920010
			}
		}
	},
	usexp = {
		totalframe = 85,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201920_xp",
					0.6
				}
			},
			{
				frame = 64,
				id = 201930010
			},
			{
				frame = 68,
				id = 201930010
			},
			{
				frame = 72,
				id = 201930010
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 85,
	bgfile = "201920_bg",
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
			texture = "role/201920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/Kirie_05",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 25,
				startframe = 10
			},
			{
				scale = 1,
				totalframe = 50,
				startframe = 35
			}
		},
		move = {
			{
				distance = 150,
				totalframe = 35,
				startframe = 50,
				time = 1
			}
		}
	}
}

return var_0_0
