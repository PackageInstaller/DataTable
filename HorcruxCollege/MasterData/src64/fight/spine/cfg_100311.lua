return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				id = 10031161,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "100311_effect",
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
		totalframe = 20,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				id = 10031171,
				effect = {
					{
						ani = "skill",
						name = "100311_effect",
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
