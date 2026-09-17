local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 9,
				bullet = "attack",
				sound = {
					"nengliang",
					0.4
				}
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 9,
				bullet = "attack",
				sound = {
					"nengliang",
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
		totalframe = 20,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 10,
				id = 70120001,
				effect = {
					{
						ani = "shield",
						name = "70100_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"nengliang",
					0.4
				}
			}
		}
	},
	useskill2 = {
		totalframe = 20,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 8,
				bullet = "skill2",
				sound = {
					"nengliang",
					0.4
				}
			}
		}
	},
	useskill3 = {
		totalframe = 20,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 15,
				bullet = "skill3",
				sound = {
					"nengliang",
					0.4
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 70,
	bgfile = "70100_bg",
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
			texture = "role/70100.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 62,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 40,
				startframe = 30
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 40,
				startframe = 30,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 71,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 64,
			id = 70130001,
			effect = {
				{
					ani = "shield",
					name = "70100_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"20000_xp1",
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
	filename = "70100_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 70110001
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "run_angry",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "70100_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "run_angry_attack",
		exe_tbl = {
			{
				frame = 5,
				id = 70121001
			}
		}
	}
}
var_0_0.extra.skill3 = {
	movingani = "run_heart",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "70100_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "run_heart_attack",
		exe_tbl = {
			{
				frame = 6,
				id = 70122001
			}
		}
	}
}

return var_0_0
