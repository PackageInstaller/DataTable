local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 5170021,
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
		totalframe = 44,
		animation = "skill",
		exe_tbl = {
			{
				id = 5170031,
				frame = 27
			},
			{
				id = 5170031,
				frame = 30
			},
			{
				id = 5170031,
				frame = 33
			},
			{
				id = 5170032,
				frame = 35,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 200,
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
		totalframe = 75,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 5170061,
				behitted = "hitdown",
				frame = 42
			},
			{
				id = 5170061,
				behitted = "hitdown",
				frame = 44
			},
			{
				id = 5170061,
				behitted = "hitdown",
				frame = 46
			},
			{
				id = 5170061,
				behitted = "hitdown",
				frame = 48
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
	}
}

return var_0_0
