return {
	attack = {
		totalframe = 27,
		animation = "attack",
		exe_tbl = {
			{
				id = 71210001,
				frame = 13,
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
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				id = 71220001,
				frame = 23,
				shake = {
					x = 4,
					y = 4
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
		totalframe = 55,
		animation = "xp",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 41,
				sound = "20120_skill",
				id = 71230001,
				shake = {
					x = 0,
					y = 8
				}
			}
		}
	}
}
