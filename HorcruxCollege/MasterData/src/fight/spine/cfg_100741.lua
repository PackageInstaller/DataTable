return {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10074121,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "100741_effect",
						offsetZ = 1,
						offsetY = 1,
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
				id = 10074131,
				frame = 16,
				effect = {
					{
						ani = "skill",
						name = "100741_effect",
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
		totalframe = 45,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 9,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 14,
							posx = -100
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 10074141,
				frame = 23,
				shake = {
					x = 0,
					y = 8
				}
			}
		}
	}
}
