return {
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 51510001,
				frame = 9,
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
				id = 51520001,
				frame = 20,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 51520001,
				frame = 35,
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
		totalframe = 75,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 46,
				behitted = "hitdown",
				id = 51530001,
				shake = {
					x = 0,
					y = 6
				}
			},
			{
				frame = 50,
				behitted = "hitdown",
				id = 51530001,
				shake = {
					x = 0,
					y = 6
				}
			},
			{
				frame = 55,
				behitted = "hitdown",
				id = 51530001,
				shake = {
					x = 0,
					y = 6
				}
			},
			{
				frame = 60,
				behitted = "hitdown",
				id = 51530001,
				shake = {
					x = 0,
					y = 6
				}
			}
		}
	}
}
