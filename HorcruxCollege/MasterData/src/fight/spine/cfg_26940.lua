local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 26910010,
				frame = 18,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				id = 26910010,
				frame = 18,
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
	skill_back = {
		{
			{
				method = "useSkill",
				param = "useback"
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
					"26920_skill",
					0.6
				}
			},
			{
				frame = 21,
				id = 26920010
			},
			{
				frame = 38,
				id = 26920010
			}
		}
	},
	usexp = {
		totalframe = 120,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_idle"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26920_xp",
					0.6
				}
			},
			{
				frame = 55,
				id = 26930010
			},
			{
				frame = 70,
				id = 26930010
			},
			{
				frame = 85,
				id = 26930010
			},
			{
				frame = 100,
				id = 26930010
			},
			{
				frame = 110,
				id = 26930010
			}
		}
	},
	xp_idle = {
		totalframe = 10,
		animation = "idle",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "blink",
						param = {
							distance = 450
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 2,
				id = 26930012
			}
		}
	},
	useback = {
		totalframe = 23,
		animation = "skill",
		action_on_start = {
			{
				startframe = 20,
				action = {
					{
						method = "blink_back"
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 10,
				id = 26930011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 120,
	bgfile = "26940_bg",
	bgfileflipX = true,
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
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26920_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 115,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 100,
				startframe = 0
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 1,
				startframe = 0,
				time = 0.1
			},
			{
				distance = 200,
				totalframe = 120,
				startframe = 1,
				time = 0.1
			}
		}
	}
}

return var_0_0
