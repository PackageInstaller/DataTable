return {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10081120,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "100811_effect",
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
		totalframe = 50,
		animation = "skill",
		action_on_start = {
			{
				startframe = 10,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 23,
							posx = -100
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10081130,
				frame = 35,
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "skill",
						name = "100811_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
