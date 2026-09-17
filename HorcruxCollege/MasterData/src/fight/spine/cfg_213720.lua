local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 213710010,
				frame = 13
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		turnbacklimit = false,
		totalframe = 50,
		animation = "skill",
		action_on_start = {
			{
				startframe = 26,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 5,
							posx = -120
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 1,
				id = 213720010
			},
			{
				frame = 32,
				id = 213720012
			},
			{
				frame = 35,
				id = 213720011
			}
		}
	},
	usexp = {
		totalframe = 93,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_xp",
					0.6
				}
			},
			{
				frame = 1,
				id = 213730010
			},
			{
				frame = 36,
				id = 213730011
			},
			{
				frame = 46,
				id = 213730011
			},
			{
				frame = 56,
				id = 213730011
			},
			{
				frame = 66,
				id = 213730011
			},
			{
				frame = 76,
				id = 213730011
			},
			{
				frame = 77,
				id = 213730012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 92,
	bgfile = "213720_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/213720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213720_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 50,
				startframe = 32
			}
		},
		move = {}
	}
}

return var_0_0
