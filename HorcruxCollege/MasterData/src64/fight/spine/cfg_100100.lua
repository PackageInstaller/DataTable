local var_0_0 = {
	xpeffect = {},
	extra = {},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				id = 1001111,
				frame = 20,
				sound = {
					"horn_fire",
					1
				},
				effect = {
					{
						ani = "hit",
						name = "100100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				id = 1001101,
				frame = 6,
				sound = {
					"horn_fire",
					1
				},
				effect = {
					{
						ani = "hit",
						name = "100100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack3 = {
		totalframe = 20,
		animation = "attack3",
		exe_tbl = {
			{
				id = 1001101,
				frame = 6,
				sound = {
					"horn_fire",
					1
				},
				effect = {
					{
						ani = "hit",
						name = "100100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
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
	useskill1 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 20,
				id = 1001201,
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"20500_XP2",
					0.6
				},
				force = {
					{
						time = 0.4,
						shutdown = true,
						distance = 200,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 400
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 26,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 7,
				bullet = "fist",
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	}
}

var_0_0.extra.fist = {
	movingani = "run2",
	maxdistance = 500,
	movingtype = "lockdirection",
	speed = 400,
	offsetZ = 1,
	filename = "100100_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.3,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		exe_tbl = {
			{
				id = 1001211,
				frame = 5,
				shake = {
					x = 1,
					y = 0
				}
			},
			{
				id = 1001212,
				frame = 90,
				shake = {
					x = 1,
					y = 0
				}
			}
		}
	},
	destroy = {
		animation = "run2-attack",
		totalframe = 13
	}
}
var_0_0.useskill3 = {
	totalframe = 25,
	turnbacklimit = true,
	animation = "skill3",
	exe_tbl = {
		{
			id = 1001221,
			bullet = "fire",
			frame = 20,
			shake = {
				x = 1,
				y = 1
			}
		},
		{
			id = 1001222,
			frame = 25,
			shake = {
				x = 1,
				y = 1
			}
		},
		{
			id = 1001223,
			frame = 30,
			shake = {
				x = 1,
				y = 1
			}
		},
		{
			id = 1001224,
			frame = 35,
			shake = {
				x = 1,
				y = 1
			}
		}
	}
}
var_0_0.extra.fire = {
	movingtype = "lockposition",
	maxdistance = 1000,
	animation = "run2",
	speed = 1000,
	offsetZ = 1,
	filename = "100100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		pos = 100
	},
	attack = {
		animation = "skill3-fire",
		totalframe = 28
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp1"
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 120,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			behitted = "hitdown",
			frame = 40,
			id = 1001301,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20500_XP2",
				0.6
			},
			forceY = {
				{
					speed = 300
				}
			}
		},
		{
			behitted = "hitdown",
			frame = 50,
			id = 1001301,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20500_XP2",
				0.6
			},
			forceY = {
				{
					speed = 300
				}
			}
		},
		{
			behitted = "hitdown",
			frame = 81,
			id = 1001302,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20500_XP2",
				0.6
			},
			forceY = {
				{
					speed = 400
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
	bgfile = "42080_bg",
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
			startframe = 4,
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
				distance = 250,
				totalframe = 60,
				startframe = 15,
				time = 0.2
			}
		}
	}
}

return var_0_0
