local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 9,
				bullet = "attack",
				sound = {
					"nengliang",
					0.6
				}
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
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
			}
		}
	},
	xp3 = {
		{
			{
				method = "useSkill",
				param = "usexp3"
			}
		}
	},
	xp4 = {
		{
			{
				method = "useSkill",
				param = "usexp4"
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
	useskill1 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 12,
				id = 21120001,
				sound = {
					"zhiliao",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 25,
		animation = "skill2",
		exe_tbl = {
			{
				id = 21121001,
				frame = 20,
				sound = {
					"nengliang",
					0.6
				}
			}
		}
	},
	xpeffect = {}
}

var_0_0.xpeffect.test = {
	totalframe = 31,
	bgfile = "21100_bg",
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/21104.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			time = 0.1,
			totalframe = 3,
			startframe = 27,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				startframe = 8,
				scale = 1.2,
				outtime = 0.2,
				totalframe = 21,
				intime = 0.1
			}
		},
		move = {
			{
				distanceY = 100,
				totalframe = 21,
				startframe = 8,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	xpeffect = "test",
	totalframe = 61,
	animation = "xp",
	lock_screen = {
		texture = "role/21104.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 33,
			id = 21130001,
			effect = {
				{
					ani = "xp",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"zhiliao",
				0.6
			}
		}
	}
}
var_0_0.usexp1 = {
	xpeffect = "test",
	totalframe = 61,
	animation = "xp",
	lock_screen = {
		texture = "role/21104.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 33,
			id = 21134001,
			effect = {
				{
					ani = "xp",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"zhiliao",
				0.6
			}
		}
	}
}
var_0_0.usexp2 = {
	xpeffect = "test",
	totalframe = 61,
	animation = "xp",
	lock_screen = {
		texture = "role/21104.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 33,
			id = 21134101,
			effect = {
				{
					ani = "xp",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"zhiliao",
				0.6
			}
		}
	}
}
var_0_0.usexp3 = {
	xpeffect = "test",
	totalframe = 61,
	animation = "xp",
	lock_screen = {
		texture = "role/21104.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 33,
			id = 21135001,
			effect = {
				{
					ani = "xp",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"zhiliao",
				0.6
			}
		}
	}
}
var_0_0.usexp4 = {
	xpeffect = "test",
	totalframe = 61,
	animation = "xp",
	lock_screen = {
		texture = "role/21104.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 33,
			id = 21140001,
			effect = {
				{
					ani = "xp",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"zhiliao",
				0.6
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
	filename = "21100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 1.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0.3,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 21110001,
				frame = 1
			}
		}
	}
}

return var_0_0
