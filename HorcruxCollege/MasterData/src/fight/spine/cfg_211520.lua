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
				id = 211510010,
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
		turnbacklimit = true,
		totalframe = 45,
		animation = "skill",
		action_on_start = {
			{
				startframe = 24,
				action = {
					{
						method = "grab",
						param = {
							bonename = "role",
							finaloffset = cc.p(100, 0)
						}
					}
				}
			},
			{
				startframe = 32,
				action = {
					{
						method = "releasegrab"
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_skill_xp",
					0.7
				}
			},
			{
				frame = 21,
				id = 211520010
			},
			{
				frame = 31,
				id = 211520011
			},
			{
				frame = 32,
				id = 211520012
			}
		}
	},
	usexp = {
		totalframe = 139,
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
				frame = 43,
				id = 211530010
			},
			{
				frame = 57,
				id = 211530010
			},
			{
				frame = 71,
				id = 211530010
			},
			{
				frame = 83,
				id = 211530010
			},
			{
				frame = 113,
				id = 211530010
			},
			{
				frame = 114,
				id = 211530011
			},
			{
				frame = 115,
				id = 211530012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 138,
	bgfile = "211520_bg",
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
			texture = "role/211520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/211520_xp",
				1
			}
		}
	},
	lockframe = {},
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
				distance = 250,
				time = 2,
				distanceY = 0,
				totalframe = 65,
				startframe = 16
			}
		}
	}
}

return var_0_0
