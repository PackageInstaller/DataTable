return {
	attack = {
		totalframe = 33,
		animation = "attack",
		exe_tbl = {
			{
				id = 37310001,
				frame = 11
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
		exe_tbl = {
			{
				id = 37320011,
				frame = 32,
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
		totalframe = 88,
		animation = "xp",
		exe_tbl = {
			{
				id = 37330101,
				frame = 45,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				id = 37330101,
				frame = 60
			},
			{
				id = 37330101,
				frame = 70
			}
		}
	}
}
