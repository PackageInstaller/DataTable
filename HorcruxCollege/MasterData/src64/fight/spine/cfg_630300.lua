return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 18,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				id = 63030021
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
		totalframe = 27,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 11,
				id = 63030031
			},
			{
				frame = 15,
				id = 63030031
			},
			{
				frame = 19,
				id = 63030031
			},
			{
				frame = 22,
				id = 63030031
			},
			{
				frame = 25,
				id = 63030031
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
		totalframe = 25,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 15,
				id = 63030041
			},
			{
				frame = 16,
				id = 63030042
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
		turnbacklimit = true,
		totalframe = 15,
		animation = "skill3",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 450,
							time = 0.5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 1,
				id = 63030051
			},
			{
				id = 63030052,
				behitted = "hitdown",
				frame = 14
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
		totalframe = 35,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				frame = 14,
				id = 63030061
			},
			{
				frame = 20,
				id = 63030061
			},
			{
				frame = 28,
				id = 63030061
			},
			{
				frame = 34,
				id = 63030062
			}
		}
	}
}
