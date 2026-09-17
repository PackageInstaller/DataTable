return {
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				id = 50110001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				},
				sound = {
					"huiwu",
					0.3
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "xp_begin"
			}
		}
	},
	xp_begin = {
		turnbacklimit = true,
		totalframe = 10,
		anitype = "released",
		nextani = true,
		animation = "xp1",
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 10,
					posx = 80
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.4
				}
			}
		}
	},
	xp_attack = {
		totalframe = 21,
		turnbacklimit = true,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 15,
				id = 50130001,
				sound = {
					"huiwu",
					0.3
				}
			}
		}
	}
}
