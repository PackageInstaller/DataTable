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
				id = 208910011,
				frame = 10
			},
			{
				frame = 19,
				id = 208910012
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
				id = 208910010,
				frame = 12
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
		totalframe = 53,
		animation = "skill",
		action_on_start = {
			{
				startframe = 27,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 7,
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
				frame = 9,
				bullet = "skill"
			},
			{
				frame = 41,
				id = 208920012
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "run_skill",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "208920_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 13,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 208920010
			},
			{
				frame = 2,
				id = 208920011
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 96,
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
			frame = 38,
			id = 208930010
		},
		{
			frame = 42,
			id = 208930010
		},
		{
			frame = 46,
			id = 208930010
		},
		{
			frame = 50,
			id = 208930010
		},
		{
			frame = 74,
			id = 208930011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
	bgfile = "208920_bg",
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
			texture = "role/208920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/208920_xp",
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
