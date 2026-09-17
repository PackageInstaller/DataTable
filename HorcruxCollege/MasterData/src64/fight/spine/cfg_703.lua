local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 10,
				bullet = "attack",
				sound = {
					"gunhit",
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
				frame = 10,
				bullet = "attack",
				sound = {
					"gunhit",
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
				frame = 17,
				bullet = "skill1",
				sound = {
					"gunhit",
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
				frame = 11,
				id = 70321001
			}
		}
	},
	useskill3 = {
		totalframe = 30,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 19,
				id = 70322001
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
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
			texture = "role/70300.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.95,
				totalframe = 55,
				startframe = 30
			}
		},
		move = {
			{
				distance = -100,
				totalframe = 55,
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
			frame = 33,
			bullet = "xp",
			sound = {
				"shilian",
				0.8
			}
		},
		{
			frame = 40,
			bullet = "xp"
		},
		{
			frame = 47,
			bullet = "xp"
		},
		{
			frame = 54,
			bullet = "xp"
		},
		{
			frame = 61,
			bullet = "xp",
			sound = {
				"shilian",
				0.8
			}
		},
		{
			frame = 68,
			bullet = "xp"
		},
		{
			frame = 75,
			bullet = "xp"
		},
		{
			frame = 83,
			bullet = "xp"
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "70300_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
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
				frame = 1,
				id = 70310001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "70300_effect",
	size = {
		width = 80,
		height = 100
	},
	initpos = {
		offsetY = 0.32,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.46,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 70320001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 250,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "70300_effect",
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
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 70330001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
