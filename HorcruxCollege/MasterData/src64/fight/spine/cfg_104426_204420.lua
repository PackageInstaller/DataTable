local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack2 = {
		totalframe = 30,
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
				id = 204410010,
				frame = 20
			}
		}
	},
	attack = {
		totalframe = 30,
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
				id = 204410010,
				frame = 20
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
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 17,
				id = 204420011
			},
			{
				frame = 18,
				id = 204420010
			},
			{
				frame = 25,
				id = 204420010
			},
			{
				frame = 30,
				id = 204420010
			},
			{
				frame = 35,
				id = 204420010
			}
		}
	},
	usexp = {
		xpeffect = "xp_effect",
		totalframe = 60,
		animation = "xp",
		action_on_start = {
			{
				startframe = 10,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = -200
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_xp",
					0.6
				}
			},
			{
				frame = 40,
				id = 204430010
			},
			{
				frame = 42,
				id = 204430010
			},
			{
				frame = 44,
				id = 204430010
			},
			{
				frame = 46,
				id = 204430010
			},
			{
				frame = 48,
				id = 204430010
			},
			{
				frame = 50,
				id = 204430010
			},
			{
				frame = 51,
				id = 204430011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 60,
	bgfile = "204420_bg",
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
			texture = "role/204420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/204420_xp",
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
				scale = 0.9,
				totalframe = 90,
				startframe = 0
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
