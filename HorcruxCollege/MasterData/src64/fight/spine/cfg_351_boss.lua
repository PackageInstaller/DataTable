return {
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				id = 35110001,
				frame = 12,
				shake = {
					x = 0,
					y = 2
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
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				id = 35120001,
				frame = 11,
				shake = {
					x = 4,
					y = 4
				},
				force = {
					{
						time = 0.5,
						shutdown = true,
						distance = 400,
						object = "target"
					}
				}
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
		turnbacklimit = true,
		totalframe = 60,
		animation = "xp",
		action_on_start = {
			{
				startframe = 28,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 10,
							posx = 0
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 40,
				sound = "20120_skill",
				id = 35130001,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				frame = 44,
				forceY = {
					{
						distance = 200,
						time = 0.3
					}
				}
			}
		}
	}
}
