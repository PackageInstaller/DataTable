local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 203410011,
				frame = 18,
				effect = {
					{
						ani = "attack",
						name = "103490_203420_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 203410012,
				frame = 19,
				effect = {
					{
						ani = "attack",
						name = "103490_203420_effect",
						offsetZ = 1,
						offsetY = 0,
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		turnbacklimit = true,
		totalframe = 60,
		animation = "skill",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "grab",
						param = {
							bonename = "role",
							finaloffset = cc.p(200, 120)
						}
					}
				}
			},
			{
				startframe = 45,
				action = {
					{
						method = "releasegrab"
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 15,
				id = 203420011
			}
		}
	},
	useskill2 = {
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				id = 203420012,
				frame = 13,
				sound = {
					"20100_attack",
					0.6
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
			}
		}
	},
	usexp1 = {
		totalframe = 65,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp1",
		exe_tbl = {
			{
				frame = 45,
				id = 203430011
			},
			{
				frame = 47,
				id = 203430012
			}
		}
	},
	usexp2 = {
		totalframe = 65,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 48,
				id = 203430013
			},
			{
				id = 203430014,
				frame = 30,
				force = {
					{
						shotdown = false,
						time = 0.5,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "203420_bg",
	totalframe = 65,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
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
			texture = "role/203420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/203420_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 110,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 110,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
