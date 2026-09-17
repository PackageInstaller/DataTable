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
					"25920_attack",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "attack"
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
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
		totalframe = 60,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"25920_skill",
					0.6
				}
			},
			{
				id = 25920010,
				frame = 44,
				effect = {
					{
						ani = "skill",
						name = "25940_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 25920011
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 30,
		nextani = true,
		animation = "chong",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.5
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "realxp"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"25920_xp",
					0.6
				}
			}
		}
	},
	realxp = {
		totalframe = 60,
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 25,
				id = 25930010
			},
			{
				frame = 30,
				id = 25930010
			},
			{
				frame = 35,
				id = 25930010
			},
			{
				frame = 40,
				id = 25930010
			}
		}
	},
	usexp1 = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 30,
		nextani = true,
		animation = "chong",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 0,
							time = 0.5
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "realxp"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"25920_xp",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "25940_bg",
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
			texture = "role/25940.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/25920_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 200,
				totalframe = 95,
				startframe = 45,
				time = 0.4
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "25940_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 1.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				id = 25910010
			}
		}
	}
}

return var_0_0
