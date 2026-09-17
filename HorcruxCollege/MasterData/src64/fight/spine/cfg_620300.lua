return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				id = 62030021
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
		action_on_start = {
			{
				startframe = 5,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							frame = 13
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 5,
				sound = "21500_skill"
			},
			{
				frame = 6,
				id = 62030031
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
		totalframe = 53,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 40,
				id = 62030041
			}
		}
	}
}
