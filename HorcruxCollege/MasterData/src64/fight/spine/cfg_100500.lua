return {
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				id = 1005101,
				frame = 13
			},
			{
				frame = 16,
				id = 1005103
			},
			{
				frame = 18,
				id = 1005104
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "skill",
		exe_tbl = {
			{
				id = 1005102,
				frame = 13
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
		totalframe = 20,
		animation = "skill2",
		exe_tbl = {
			{
				id = 1005201,
				frame = 15
			}
		}
	}
}
