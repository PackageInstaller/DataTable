return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10070121,
				frame = 14,
				effect = {
					{
						ani = "attack",
						name = "100761_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				id = 10070131,
				frame = 24,
				effect = {
					{
						ani = "attack",
						name = "100761_effect",
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
