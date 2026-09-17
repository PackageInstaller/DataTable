local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"218120_attack",
					0.6
				}
			},
			{
				frame = 15,
				id = 218110010
			}
		}
	},
	attack2 = {
		{
			{
				method = "useSkill",
				param = "useattack2"
			}
		}
	},
	useattack2 = {
		turnbacklimit = true,
		totalframe = 30,
		animation = "attack2",
		action_on_start = {
			{
				startframe = 10,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 600,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"218120_attack",
					0.6
				}
			},
			{
				frame = 22,
				effect = {
					{
						ani = "buff2",
						name = "218120_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "self"
					}
				}
			},
			{
				frame = 17,
				id = 218110011
			},
			{
				frame = 18,
				id = 218110012
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
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"218120_skill",
					0.6
				}
			},
			{
				frame = 26,
				bullet = "skill1"
			}
		}
	}
}

var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "218120_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "skill",
		exe_tbl = {
			{
				id = 218120010,
				behitted = "hitdown",
				frame = 1
			},
			{
				frame = 5,
				id = 218120011
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "use_xp"
		}
	}
}
var_0_0.use_xp = {
	xpeffect = "test",
	totalframe = 100,
	nextani = true,
	animation = "xp",
	action_on_start = {
		{
			startframe = 25,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 5,
						posx = -120
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"218120_xp",
				0.6
			}
		},
		{
			frame = 8,
			effect = {
				{
					ani = "buff2",
					name = "218120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "self"
				}
			}
		},
		{
			id = 218130010,
			frame = 50,
			effect = {
				{
					ani = "xp",
					name = "218120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 218130010,
			frame = 58,
			effect = {
				{
					ani = "xp",
					name = "218120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 218130010,
			frame = 66,
			effect = {
				{
					ani = "xp",
					name = "218120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 218130010,
			frame = 72,
			effect = {
				{
					ani = "xp",
					name = "218120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 218130011,
			frame = 80,
			effect = {
				{
					ani = "xp",
					name = "218120_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 100,
			id = 218130012
		}
	}
}
var_0_0.xpeffect = {}
var_0_0.xpeffect.test = {
	focusoffset = 100,
	bgfilescale = 0.45,
	initpos = 0,
	bgfile = "218120_bg",
	totalframe = 100,
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
			texture = "role/218120.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/218120_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 13,
			startframe = 31,
			timescale = 0.6
		}
	},
	camera = {
		zoom = {},
		move = {
			{
				pos = "target",
				time = 0.2,
				distance = -150,
				totalframe = 75,
				startframe = 25
			}
		}
	}
}

return var_0_0
