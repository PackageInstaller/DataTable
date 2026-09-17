local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 13,
		animation = "attack",
		exe_tbl = {
			{
				frame = 5,
				bullet = "attack",
				sound = {
					"gunhit",
					0.6
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
	useskill1 = {
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				effect = {
					{
						ani = "attack",
						name = "21200_effect3",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 14,
				id = 21220001,
				sound = {
					"gunhit",
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
	usexp = {
		totalframe = 82,
		animation = "xp",
		lock_screen = {
			texture = "role/21204.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		exe_tbl = {
			{
				frame = 31,
				bullet = "xp",
				sound = {
					"shilian",
					0.6
				}
			},
			{
				frame = 36,
				bullet = "xp"
			},
			{
				frame = 41,
				bullet = "xp"
			},
			{
				frame = 46,
				bullet = "xp"
			},
			{
				frame = 51,
				bullet = "xp"
			},
			{
				frame = 56,
				bullet = "xp"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "21200_effect2",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.31,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.66,
		offsetX = 0.3,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 21210001,
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
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "lockdirection",
	speed = 1500,
	offsetZ = 1,
	filename = "21200_effect2",
	size = {
		width = 80,
		height = 100
	},
	initpos = {
		offsetY = 0.32,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "once",
		direction = 1
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 21230001,
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
var_0_0.usexp1 = {
	totalframe = 82,
	animation = "xp",
	lock_screen = {
		texture = "role/21204.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 31,
			bullet = "xp",
			sound = {
				"shilian",
				0.6
			}
		},
		{
			frame = 36,
			bullet = "xp"
		},
		{
			frame = 41,
			bullet = "xp"
		},
		{
			frame = 46,
			bullet = "xp"
		},
		{
			frame = 51,
			bullet = "xp"
		},
		{
			frame = 56,
			bullet = "xp"
		}
	}
}
var_0_0.usexp2 = {
	totalframe = 82,
	animation = "xp",
	lock_screen = {
		texture = "role/21205.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 31,
			bullet = "xp",
			sound = {
				"shilian",
				0.6
			}
		},
		{
			frame = 36,
			bullet = "xp"
		},
		{
			frame = 41,
			bullet = "xp"
		},
		{
			frame = 46,
			bullet = "xp"
		},
		{
			frame = 51,
			bullet = "xp"
		},
		{
			frame = 56,
			bullet = "xp"
		}
	}
}
var_0_0.usexp3 = {
	totalframe = 82,
	animation = "xp",
	lock_screen = {
		texture = "role/21205.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 31,
			bullet = "xp",
			sound = {
				"shilian",
				0.6
			}
		},
		{
			frame = 34,
			bullet = "xp"
		},
		{
			frame = 37,
			bullet = "xp"
		},
		{
			frame = 40,
			bullet = "xp"
		},
		{
			frame = 43,
			bullet = "xp"
		},
		{
			frame = 46,
			bullet = "xp"
		},
		{
			frame = 49,
			bullet = "xp"
		},
		{
			frame = 52,
			bullet = "xp"
		},
		{
			frame = 55,
			bullet = "xp"
		},
		{
			frame = 58,
			bullet = "xp"
		}
	}
}
var_0_0.usexp4 = {
	totalframe = 82,
	animation = "xp",
	lock_screen = {
		texture = "role/21210.png",
		lastframe = 30,
		zorder = 200,
		file = "xp2",
		startframe = 0,
		ani = "xp"
	},
	exe_tbl = {
		{
			frame = 31,
			bullet = "xp",
			sound = {
				"shilian",
				0.6
			}
		},
		{
			frame = 36,
			bullet = "xp"
		},
		{
			frame = 41,
			bullet = "xp"
		},
		{
			frame = 46,
			bullet = "xp"
		},
		{
			frame = 51,
			bullet = "xp"
		},
		{
			frame = 56,
			bullet = "xp"
		}
	}
}

return var_0_0
