return {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				id = 10058120,
				frame = 15
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 10058120,
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 90,
		animation = "skill",
		exe_tbl = {
			{
				id = 10058130,
				frame = 15
			}
		}
	},
	useskill2 = {
		totalframe = 40,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10058140,
				frame = 25,
				force = {
					{
						time = 0.3,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	},
	qianyao = {
		totalframe = 22,
		nextani = true,
		animation = "win",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -40,
							time = 0.3
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 44900000,
				frame = 1,
				sound = {
					"invalid",
					1.6
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "qianyao"
			}
		}
	},
	usexp = {
		totalframe = 90,
		animation = "xp",
		exe_tbl = {
			{
				id = 10058160,
				behitted = "hitdown",
				frame = 60,
				shake = {
					x = 6,
					y = 2
				}
			}
		}
	}
}
