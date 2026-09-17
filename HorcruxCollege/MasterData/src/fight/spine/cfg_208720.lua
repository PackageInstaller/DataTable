local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack2 = {
		totalframe = 25,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 208710010,
				frame = 13
			}
		}
	},
	attack1 = {
		totalframe = 24,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 208710010,
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
		totalframe = 40,
		animation = "skill",
		action_on_start = {
			{
				startframe = 5,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = -220
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
				frame = 25,
				id = 208720010
			},
			{
				frame = 26,
				id = 208720011
			},
			{
				frame = 27,
				id = 208720012
			}
		}
	},
	usexp = {
		totalframe = 91,
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
				frame = 44,
				id = 208730010
			},
			{
				frame = 48,
				id = 208730010
			},
			{
				frame = 54,
				id = 208730010
			},
			{
				frame = 60,
				id = 208730011
			},
			{
				frame = 68,
				id = 208730012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "208720_bg",
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
			texture = "role/208720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/208720_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 37,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 90,
				startframe = 2
			}
		},
		move = {
			{
				distance = 0,
				time = 0.5,
				distanceY = 0,
				totalframe = 90,
				startframe = 0
			}
		}
	}
}

return var_0_0
