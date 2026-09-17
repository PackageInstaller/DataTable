return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				id = 65010021
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
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 31,
				id = 65010031
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
		totalframe = 46,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 30,
				id = 65010041
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill3 = {
		totalframe = 53,
		turnbacklimit = true,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 25,
				id = 65010051
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
		totalframe = 100,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				id = 65010061,
				behitted = "hitdown",
				frame = 33
			},
			{
				id = 65010061,
				behitted = "hitdown",
				frame = 47
			},
			{
				id = 65010061,
				behitted = "hitdown",
				frame = 78
			},
			{
				id = 65010062,
				frame = 80,
				force = {
					{
						time = 0.3,
						shutdown = false,
						distance = 500,
						object = "target"
					}
				}
			}
		}
	}
}
