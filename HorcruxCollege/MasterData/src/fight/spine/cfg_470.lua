local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"470100-attack",
					0.6
				}
			},
			{
				frame = 5,
				bullet = "attack"
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
	useskill1 = {
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"470200-skill1",
					0.6
				}
			},
			{
				frame = 24,
				bullet = "skill1"
			}
		}
	},
	useskill2 = {
		totalframe = 33,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"470210-skill2",
					0.6
				}
			},
			{
				frame = 28,
				id = 47021001,
				effect = {
					{
						ani = "attack2",
						name = "47000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill3 = {
		totalframe = 27,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"470220-skill3",
					0.6
				}
			},
			{
				id = 47022001,
				frame = 23
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 75,
	bgfile = "47000_bg",
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
			texture = "role/47000.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 25,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.7,
				totalframe = 50,
				startframe = 10
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 50,
				startframe = 10,
				time = 0.1
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "qianyao"
		}
	}
}
var_0_0.qianyao = {
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
						time = 0.33
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
}
var_0_0.usexp = {
	totalframe = 76,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"470300-xp",
				0.6
			}
		},
		{
			frame = 20,
			id = 47030001,
			effect = {
				{
					ani = "attack2",
					name = "47000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 27,
			id = 47030001,
			effect = {
				{
					ani = "attack2",
					name = "47000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 35,
			id = 47030001,
			effect = {
				{
					ani = "attack2",
					name = "47000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 42,
			id = 47030001,
			effect = {
				{
					ani = "attack2",
					name = "47000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 50,
			id = 47030001,
			effect = {
				{
					ani = "attack2",
					name = "47000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run1",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "47000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack1",
		exe_tbl = {
			{
				id = 47010001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run2",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "47000_effect",
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
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack2",
		exe_tbl = {
			{
				id = 47020001,
				frame = 1
			}
		}
	}
}

return var_0_0
