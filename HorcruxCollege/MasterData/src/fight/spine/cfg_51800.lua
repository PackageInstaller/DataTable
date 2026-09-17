local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 5180021,
				frame = 22,
				effect = {
					{
						ani = "attack",
						name = "51800_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
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
		totalframe = 59,
		animation = "skill",
		exe_tbl = {
			{
				id = 5180031,
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
		totalframe = 96,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 5180061,
				behitted = "hitdown",
				frame = 68
			},
			{
				id = 5180061,
				behitted = "hitdown",
				frame = 73
			},
			{
				id = 5180061,
				behitted = "hitdown",
				frame = 78
			},
			{
				id = 5180061,
				behitted = "hitdown",
				frame = 83
			},
			{
				id = 5180061,
				behitted = "hitdown",
				frame = 88
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 96,
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
