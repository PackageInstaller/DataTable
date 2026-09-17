local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10094121,
				frame = 13
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
		turnbacklimit = true,
		totalframe = 50,
		animation = "skill",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.3
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10094131,
				frame = 12,
				effect = {
					{
						ani = "skill",
						name = "100941_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10094131,
				frame = 18
			},
			{
				id = 10094131,
				frame = 24
			},
			{
				id = 10094131,
				frame = 30
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
		totalframe = 50,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.7
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10094141,
				behitted = "hitdown",
				frame = 33
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
		totalframe = 50,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 10094161,
				behitted = "hitdown",
				frame = 15,
				effect = {
					{
						ani = "xp",
						name = "100941_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
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
