local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 10
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
		totalframe = 35,
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
				id = 209410011,
				frame = 17
			}
		}
	},
	attack1 = {
		totalframe = 26,
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
				id = 209410010,
				frame = 9
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
		totalframe = 45,
		animation = "skill",
		action_on_start = {
			{
				startframe = 33,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 10,
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
				frame = 19,
				bullet = "skill"
			},
			{
				frame = 39,
				id = 209420011
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "run_skill",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "209420_effect",
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
		totalframe = 14,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 209420010
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 77,
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
			frame = 30,
			id = 209430010
		},
		{
			frame = 39,
			id = 209430010
		},
		{
			frame = 52,
			id = 209430010
		},
		{
			frame = 59,
			id = 209430010
		},
		{
			frame = 69,
			id = 209430010
		},
		{
			frame = 70,
			id = 209430011
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 76,
	bgfile = "209420_bg",
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
			texture = "role/209420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/209420_xp",
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
		move = {}
	}
}

return var_0_0
