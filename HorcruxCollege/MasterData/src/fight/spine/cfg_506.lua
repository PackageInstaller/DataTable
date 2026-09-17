return {
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				id = 50610001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				},
				sound = {
					"chui",
					0.3
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
		totalframe = 30,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "xp"
			},
			{
				frame = 20,
				id = 50630001,
				sound = {
					"chui",
					0.4
				}
			}
		}
	}
}
