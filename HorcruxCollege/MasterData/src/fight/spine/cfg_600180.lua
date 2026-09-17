return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				id = 60018021,
				effect = {
					{
						ani = "attack",
						name = "600180_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
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
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				id = 60018031,
				behitted = "hitdown",
				frame = 15
			}
		}
	}
}
