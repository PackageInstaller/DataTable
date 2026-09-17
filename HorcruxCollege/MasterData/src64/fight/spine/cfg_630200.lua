return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				id = 63020021
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
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 11,
				id = 63020031
			},
			{
				frame = 13,
				id = 63020031
			},
			{
				frame = 16,
				id = 63020031
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
		totalframe = 25,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 14,
				id = 63020041
			},
			{
				frame = 22,
				id = 63020042
			}
		}
	}
}
