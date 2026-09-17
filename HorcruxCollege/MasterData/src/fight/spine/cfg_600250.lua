return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60025021,
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
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				1,
				frame = 1,
				sound = "fire1"
			},
			{
				id = 60025031,
				frame = 25
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
		totalframe = 60,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 11,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 400,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "410220-skill3"
			},
			{
				id = 60025041,
				frame = 45
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
		totalframe = 112,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "20600_xp"
			},
			{
				id = 60025061,
				frame = 30,
				effect = {
					{
						ani = "xp",
						name = "600250_effect",
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
