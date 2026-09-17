local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60019021,
				frame = 13,
				effect = {
					{
						ani = "attack",
						name = "600190_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = "27020_skill"
			},
			{
				id = 60019031,
				frame = 35,
				effect = {
					{
						ani = "skill",
						name = "600190_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
		turnbacklimit = true,
		totalframe = 70,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 12,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							time = 0.25
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 40,
				sound = "22120_skill"
			},
			{
				id = 60019041,
				behitted = "hitdown",
				frame = 45
			},
			{
				id = 60019041,
				behitted = "hitdown",
				frame = 50
			},
			{
				id = 60019041,
				behitted = "hitdown",
				frame = 55
			},
			{
				id = 60019041,
				behitted = "hitdown",
				frame = 60
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
		totalframe = 80,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "22220_xp"
			},
			{
				id = 60019061,
				frame = 50
			},
			{
				id = 60019061,
				frame = 57
			},
			{
				id = 60019061,
				behitted = "hitdown",
				frame = 65
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 80,
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
