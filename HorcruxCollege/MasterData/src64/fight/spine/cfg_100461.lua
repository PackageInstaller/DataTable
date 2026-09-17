local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 7,
					range = 10
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
				id = 10046121,
				frame = 18
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 10046122,
				frame = 16
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
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							time = 1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 17,
				id = 10046131
			},
			{
				id = 10046132,
				behitted = "hitdown",
				frame = 36
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill2 = {
		totalframe = 50,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "100461_skill"
			},
			{
				id = 10046141,
				frame = 30,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				}
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill3 = {
		totalframe = 40,
		animation = "skill3",
		exe_tbl = {
			{
				id = 10046151,
				frame = 16
			},
			{
				frame = 25,
				behitted = "hitdown",
				id = 10046151
			},
			{
				id = 10046152,
				frame = 37
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
	usexp = {
		totalframe = 85,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100461_xp"
			},
			{
				id = 10046161,
				frame = 16
			},
			{
				id = 10046161,
				frame = 25
			},
			{
				id = 10046161,
				frame = 32
			},
			{
				id = 10046161,
				frame = 39
			},
			{
				id = 10046161,
				frame = 47
			},
			{
				id = 10046162,
				behitted = "hitdown",
				frame = 73,
				forceY = {
					{
						speed = 1000
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "22700_bg",
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
				totalframe = 66,
				startframe = 15
			}
		},
		move = {
			{
				distance = 250,
				totalframe = 22,
				startframe = 56,
				time = 0.3
			}
		}
	}
}

return var_0_0
