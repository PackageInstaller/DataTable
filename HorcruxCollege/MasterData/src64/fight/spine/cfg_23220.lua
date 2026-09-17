local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23220-attack",
					0.6
				}
			},
			{
				id = 23210001,
				frame = 16
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
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1 = {
		totalframe = 67,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23220-skill",
					0.6
				}
			},
			{
				id = 23220001,
				frame = 34,
				shake = {
					x = 0,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_1 = {
		totalframe = 67,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23220-skill",
					0.6
				}
			},
			{
				id = 23220101,
				frame = 34,
				shake = {
					x = 0,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 67,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23220-skill",
					0.6
				}
			},
			{
				id = 23220201,
				frame = 34,
				shake = {
					x = 0,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_3 = {
		totalframe = 67,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23220-skill",
					0.6
				}
			},
			{
				id = 23220301,
				frame = 34,
				shake = {
					x = 0,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 129,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23220-xp",
					0.6
				}
			},
			{
				frame = 89,
				id = 20850001,
				bullet = "xp"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 129,
	bgfile = "23200_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/23220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23220_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 91,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 77
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 30,
				startframe = 77,
				time = 0.5
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_attact",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "23200_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0,
		offsetX = 0.5,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 40,
		animation = "xp_attact",
		exe_tbl = {
			{
				id = 23230001,
				frame = 5
			}
		}
	}
}

return var_0_0
