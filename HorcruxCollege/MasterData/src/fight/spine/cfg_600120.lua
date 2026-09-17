return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				id = 60012021
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
				frame = 1,
				sound = "21500_skill"
			},
			{
				id = 60012031,
				frame = 17,
				effect = {
					{
						ani = "attack",
						name = "600120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "self"
					}
				}
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
		turnbacklimit = true,
		totalframe = 75,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 20,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							time = 1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				id = 60012041,
				frame = 75,
				effect = {
					{
						ani = "skill2",
						name = "600120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
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
		totalframe = 70,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				id = 60012061,
				frame = 40,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "xp",
						name = "600120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			}
		}
	}
}
