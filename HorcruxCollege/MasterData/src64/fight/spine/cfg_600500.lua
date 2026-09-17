local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60050021,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "600500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
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
		totalframe = 35,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 26,
				id = 60050031
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
		totalframe = 35,
		animation = "skill2",
		exe_tbl = {
			{
				id = 60050041,
				frame = 24,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "600500_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "xp_begin"
			}
		}
	},
	xp_begin = {
		turnbacklimit = true,
		totalframe = 35,
		nextani = true,
		animation = "run",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "add_anti_hitdown"
					}
				}
			},
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 35,
							posx = -200
						}
					}
				}
			}
		},
		xpeffect = {
			conf = "xp_effect",
			startframe = 35
		},
		action_on_complete = {
			{
				method = "remove_anti_hitdown"
			},
			{
				method = "useSkill",
				param = "xp_attack"
			}
		}
	},
	xp_attack = {
		totalframe = 50,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 60050061,
				behitted = "hitdown",
				frame = 35
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
	bgfile = "40000_bg",
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
			totalframe = 5,
			startframe = 30,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.75,
				totalframe = 15,
				startframe = 0
			}
		},
		move = {
			{
				pos = "target",
				time = 0.5,
				distance = -100,
				totalframe = 10,
				startframe = 0
			}
		}
	}
}

return var_0_0
