return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60020021,
				frame = 14,
				effect = {
					{
						ani = "attack",
						name = "600200_effect",
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = "240_skill"
			},
			{
				id = 60020031,
				frame = 21
			},
			{
				id = 60020031,
				frame = 24
			},
			{
				id = 60020031,
				behitted = "hitdown",
				frame = 28
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
		totalframe = 40,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "200300-xp"
			},
			{
				id = 60020041,
				frame = 15,
				effect = {
					{
						ani = "buff",
						name = "600200_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 2,
						object = "self"
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
		totalframe = 125,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				id = 60020061,
				frame = 30
			}
		}
	}
}
