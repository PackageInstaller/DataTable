return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10034161,
				frame = 13,
				effect = {
					{
						ani = "attack",
						name = "100341_effect",
						offsetZ = 0,
						offsetY = 1,
						offsetX = -1.5,
						object = "target"
					}
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 10034171,
				frame = 25,
				force = {
					{
						time = 0.3,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				},
				effect = {
					{
						ani = "skill",
						name = "100341_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
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
		totalframe = 70,
		animation = "xp",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 10034191,
				frame = 35,
				shake = {
					x = 6,
					y = 2
				},
				effect = {
					{
						ani = "xp",
						name = "100341_effect",
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
