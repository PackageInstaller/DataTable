local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack2 = {
		totalframe = 29,
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
				id = 206010010,
				frame = 12
			}
		}
	},
	attack = {
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
				id = 206010010,
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
		totalframe = 27,
		animation = "skill",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							frame = 8
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
				frame = 6,
				id = 206020010
			},
			{
				frame = 14,
				id = 206020011
			}
		}
	},
	usexp = {
		totalframe = 108,
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
				frame = 15,
				id = 206030010
			},
			{
				frame = 25,
				id = 206030010
			},
			{
				frame = 44,
				id = 206030010
			},
			{
				frame = 53,
				id = 206030010
			},
			{
				frame = 62,
				id = 206030010
			},
			{
				frame = 95,
				id = 206030011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 108,
	bgfile = "206020_bg",
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
			texture = "role/206020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/206020_xp",
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
