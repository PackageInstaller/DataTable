local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 5150021,
				frame = 11
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
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 50,
		animation = "skill",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.4
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 5150031,
				frame = 20
			},
			{
				id = 5150031,
				frame = 39
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
		totalframe = 75,
		xpeffect = "xp_effect",
		animation = "xp2",
		exe_tbl = {
			{
				id = 5150061,
				behitted = "hitdown",
				frame = 55,
				force = {
					{
						time = 1,
						shutdown = false,
						distance = 500,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 75,
	bgfile = "45080_bg",
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
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 10
			}
		},
		move = {
			{
				distance = 250,
				time = 0.3,
				distanceY = 0,
				totalframe = 30,
				startframe = 46
			}
		}
	}
}

return var_0_0
