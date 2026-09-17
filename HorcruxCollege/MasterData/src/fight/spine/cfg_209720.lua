local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 10,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack2"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack1"
			}
		}
	},
	attack2 = {
		totalframe = 29,
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
				frame = 14,
				behitted = "hitdown",
				id = 209710010
			}
		}
	},
	attack1 = {
		totalframe = 27,
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
				id = 209710010,
				frame = 14
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
		totalframe = 49,
		turnbacklimit = false,
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
				frame = 1,
				id = 209720010
			},
			{
				id = 209720011,
				behitted = "hitdown",
				frame = 17
			},
			{
				id = 209720011,
				behitted = "hitdown",
				frame = 38
			},
			{
				frame = 39,
				id = 209720012
			},
			{
				frame = 40,
				id = 209720013
			}
		}
	},
	usexp = {
		totalframe = 107,
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
				frame = 31,
				id = 209730010
			},
			{
				frame = 34,
				id = 209730010
			},
			{
				frame = 53,
				id = 209730010
			},
			{
				frame = 55,
				id = 209730011
			},
			{
				frame = 57,
				id = 209730012
			},
			{
				frame = 59,
				id = 209730013
			},
			{
				frame = 61,
				id = 209730014
			},
			{
				frame = 62,
				id = 209730015
			},
			{
				frame = 63,
				id = 209730016
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 106,
	bgfile = "209720_bg",
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
			texture = "role/209720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/209720_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 35,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 1,
				totalframe = 87,
				startframe = 35
			}
		},
		move = {
			{
				distance = 100,
				time = 0.5,
				distanceY = 0,
				totalframe = 87,
				startframe = 35
			}
		}
	}
}

return var_0_0
