return {
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				id = 71110001,
				frame = 10,
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
				id = 71120001,
				frame = 15,
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
		totalframe = 50,
		animation = "xp",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 32,
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
