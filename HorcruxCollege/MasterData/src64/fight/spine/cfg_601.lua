local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 15,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 10,
				bullet = "attack",
				sound = {
					"fire",
					0.4
				}
			}
		}
	},
	attack2 = {
		totalframe = 15,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 10,
				bullet = "attack",
				sound = {
					"fire",
					0.4
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
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "qianyao"
			}
		}
	},
	qianyao = {
		totalframe = 22,
		nextani = true,
		animation = "win",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -50,
							time = 0.1
						}
					}
				}
			}
		},
		xpeffect = {
			conf = "xp_effect",
			startframe = 30
		},
		exe_tbl = {
			{
				id = 44900000,
				frame = 1,
				sound = {
					"invalid",
					1.6
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 6,
				bullet = "attack",
				sound = {
					"fire1",
					0.4
				}
			},
			{
				frame = 13,
				bullet = "attack",
				sound = {
					"fire1",
					0.4
				}
			},
			{
				frame = 24,
				bullet = "attack",
				sound = {
					"fire1",
					0.4
				}
			}
		}
	},
	useskill2 = {
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				id = 60121001,
				frame = 15,
				sound = {
					"fire1",
					0.4
				}
			}
		}
	},
	useskill3 = {
		totalframe = 35,
		animation = "skill3",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 25,
				id = 60122001,
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"fire1",
					0.4
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "47000_bg",
	locktarget = {
		locktarget = true
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
			texture = "role/60100.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 49,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.9,
				totalframe = 25,
				startframe = 30
			}
		},
		move = {
			{
				distance = 80,
				totalframe = 25,
				startframe = 30,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 91,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 46,
			bullet = "xp",
			sound = {
				"20500_xp1",
				1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "60100_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 5,
		animation = "attack",
		exe_tbl = {
			{
				frame = 5,
				id = 60110001
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "60100_effect2",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 37,
		animation = "xp_attack",
		exe_tbl = {
			{
				frame = 5,
				id = 60130001,
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"fire",
					2
				}
			},
			{
				frame = 13,
				id = 60130001,
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"fire",
					2
				}
			},
			{
				behitted = "hitdown",
				frame = 21,
				id = 60130001,
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"fire",
					2
				}
			}
		}
	}
}

return var_0_0
