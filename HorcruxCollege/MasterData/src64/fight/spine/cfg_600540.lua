return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60054021,
				frame = 12,
				effect = {
					{
						ani = "attack",
						name = "600540_effect",
						offsetZ = 1,
						offsetY = 1,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 60054021,
				frame = 17,
				effect = {
					{
						ani = "attack",
						name = "600540_effect",
						offsetZ = 1,
						offsetY = 1,
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
				id = 60054031,
				frame = 20,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "600540_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			}
		}
	}
}
