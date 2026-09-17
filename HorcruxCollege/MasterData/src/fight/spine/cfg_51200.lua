local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 5120021,
				frame = 14
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
		animation = "skill",
		exe_tbl = {
			{
				id = 5120031,
				frame = 33,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 140,
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
				param = "usexp"
			}
		}
	},
	usexp = {
		xpeffect = "xp_effect",
		totalframe = 81,
		animation = "xp",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 250
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 5120061,
				frame = 40
			},
			{
				id = 5120061,
				frame = 60,
				force = {
					{
						time = 1,
						shutdown = false,
						distance = 400,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 700
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 81,
	bgfile = "45080_bg",
	locktarget = {
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	}
}

return var_0_0
