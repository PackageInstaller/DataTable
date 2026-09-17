local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 38,
		animation = "attack",
		exe_tbl = {
			{
				id = 5110021,
				frame = 22
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
		totalframe = 55,
		animation = "skill",
		exe_tbl = {
			{
				id = 5110031,
				frame = 43
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
		totalframe = 104,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 5110061,
				frame = 65
			},
			{
				id = 5110061,
				frame = 68
			},
			{
				id = 5110061,
				frame = 71
			},
			{
				id = 5110061,
				frame = 75
			},
			{
				id = 5110061,
				frame = 78
			},
			{
				id = 5110061,
				frame = 81
			},
			{
				id = 5110061,
				frame = 85
			},
			{
				id = 5110061,
				frame = 88
			},
			{
				id = 5110061,
				frame = 91
			},
			{
				id = 5110061,
				frame = 95
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 104,
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
