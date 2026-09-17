return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60022021,
				frame = 10
			},
			{
				id = 60022021,
				frame = 15
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
				sound = "27520_skill"
			},
			{
				id = 60022031,
				frame = 20,
				force = {
					{
						shotdown = false,
						time = 0.5,
						distance = 300,
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
		totalframe = 50,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 12,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 400,
							time = 0.5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				0.8,
				frame = 1,
				sound = "27520_skill"
			},
			{
				0.8,
				frame = 15,
				sound = "27520_skill"
			},
			{
				0.8,
				frame = 30,
				sound = "27520_skill"
			},
			{
				id = 60022041,
				behitted = "hitdown",
				frame = 22
			},
			{
				id = 60022041,
				behitted = "hitdown",
				frame = 30
			},
			{
				id = 60022041,
				behitted = "hitdown",
				frame = 38
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
		animation = "xp",
		exe_tbl = {
			{
				1.2,
				frame = 1,
				sound = "21500_xp1"
			},
			{
				id = 60022061,
				behitted = "hitdown",
				frame = 55
			}
		}
	}
}
