return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				id = 62020021
			},
			{
				frame = 10,
				id = 62020021
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
		totalframe = 27,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 14,
				id = 62020031
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
		totalframe = 35,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 1,
				id = 62020041
			},
			{
				frame = 22,
				id = 62020042
			}
		}
	}
}
