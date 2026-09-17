return {
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 511100001,
				frame = 15,
				sound = {
					"huiwu",
					0.3
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
		totalframe = 47,
		animation = "skill",
		exe_tbl = {
			{
				id = 51120001,
				frame = 25,
				shake = {
					x = 2,
					y = 0
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
		totalframe = 90,
		animation = "xp",
		exe_tbl = {
			{
				frame = 55,
				behitted = "hitdown",
				id = 51130001,
				shake = {
					x = 0,
					y = 6
				}
			},
			{
				frame = 60,
				behitted = "hitdown",
				id = 51130001,
				shake = {
					x = 0,
					y = 6
				}
			},
			{
				frame = 65,
				behitted = "hitdown",
				id = 51130001,
				shake = {
					x = 0,
					y = 6
				}
			}
		}
	}
}
