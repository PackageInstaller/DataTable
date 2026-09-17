local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 9,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 9,
				bullet = "attack"
			}
		}
	},
	attack3 = {
		totalframe = 20,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 9,
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
				id = 90320001,
				frame = 19
			}
		}
	},
	useskill2 = {
		totalframe = 20,
		animation = "skill2",
		exe_tbl = {
			{
				id = 90321001,
				frame = 10
			}
		}
	},
	useskill3 = {
		totalframe = 35,
		animation = "skill3",
		exe_tbl = {
			{
				id = 90322001,
				frame = 20,
				effect = {
					{
						ani = "skill3",
						name = "90300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "44000_bg",
	locktarget = {
		locktarget = false
	},
	locktarget = {
		locktargetpool = "all"
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
			texture = "role/90300.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 79,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 60,
				startframe = 30
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 60,
				startframe = 30,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	xpeffect = "xp_effect",
	totalframe = 101,
	animation = "xp",
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
	},
	exe_tbl = {
		{
			frame = 27,
			shake = {
				x = 0,
				y = 2
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			id = 90330001,
			frame = 37,
			shake = {
				x = 0,
				y = 2
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			frame = 34,
			shake = {
				x = 0,
				y = 2
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			id = 90330001,
			frame = 44,
			shake = {
				x = 0,
				y = 2
			}
		},
		{
			frame = 39,
			shake = {
				x = 0,
				y = 2
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			id = 90330001,
			frame = 49,
			shake = {
				x = 0,
				y = 2
			}
		},
		{
			frame = 45,
			shake = {
				x = 0,
				y = 2
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			id = 90330001,
			frame = 55,
			shake = {
				x = 0,
				y = 2
			}
		},
		{
			frame = 51,
			shake = {
				x = 0,
				y = 2
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			id = 90330001,
			frame = 61,
			shake = {
				x = 0,
				y = 2
			}
		},
		{
			id = 90330002,
			frame = 80,
			shake = {
				x = 0,
				y = 4
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			frame = 73,
			shake = {
				x = 0,
				y = 4
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			frame = 76,
			shake = {
				x = 0,
				y = 4
			},
			sound = {
				"260_atk",
				1
			}
		},
		{
			frame = 79,
			shake = {
				x = 0,
				y = 4
			},
			sound = {
				"260_atk",
				1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "90300_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.8,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 90210001
			}
		}
	}
}

return var_0_0
