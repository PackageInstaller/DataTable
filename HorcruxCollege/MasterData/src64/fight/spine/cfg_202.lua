local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 20210001,
				frame = 11,
				sound = {
					"liandao",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				id = 20210001,
				frame = 11,
				sound = {
					"liandao",
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
		totalframe = 25,
		animation = "skill",
		exe_tbl = {
			{
				id = 20220001,
				frame = 9,
				sound = {
					"liandao",
					0.6
				}
			},
			{
				id = 20220001,
				frame = 18,
				sound = {
					"liandao",
					0.6
				}
			}
		}
	},
	useskill2 = {
		totalframe = 20,
		nextani = true,
		animation = "skill2_1",
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill2_2"
			}
		}
	},
	useskill2_2 = {
		totalframe = 17,
		nextani = true,
		animation = "skill2_2",
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 5,
					posx = -30
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill2_3"
			}
		},
		exe_tbl = {
			{
				id = 20221001,
				frame = 4,
				sound = {
					"liandao",
					0.6
				}
			}
		}
	},
	useskill2_3 = {
		totalframe = 10,
		animation = "skill2_3",
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 4,
					posx = -150
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
	bgfile = "20200_bg",
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
			texture = "role/20202.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 59,
			timescale = 0.2
		},
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 32,
				startframe = 38
			},
			{
				scale = 1.2,
				totalframe = 10,
				startframe = 74
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 50,
				startframe = 38,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = true,
	xpeffect = "xp_effect",
	totalframe = 97,
	animation = "xp",
	exe_tbl = {
		{
			id = 20230001,
			frame = 39,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20230001,
			frame = 40,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20230001,
			frame = 45,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20230001,
			frame = 49,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20230001,
			frame = 50,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20230001,
			frame = 58,
			sound = {
				"20200_xp1"
			}
		},
		{
			behitted = "hitdown",
			id = 20230002,
			frame = 76,
			sound = {
				"20200_xp2"
			},
			shake = {
				x = 0,
				y = 6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 95,
	bgfile = "20200_bg",
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
			texture = "role/20201.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 59,
			timescale = 0.2
		},
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 32,
				startframe = 38
			},
			{
				scale = 1.2,
				totalframe = 10,
				startframe = 74
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 50,
				startframe = 38,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp1 = {
	turnbacklimit = true,
	xpeffect = "xp_effect1",
	totalframe = 97,
	animation = "xp",
	action_on_start = {
		{
			startframe = 36,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 3,
						posx = 80
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 20231001,
			frame = 39,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20231001,
			frame = 40,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20231001,
			frame = 45,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20231001,
			frame = 49,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20231001,
			frame = 50,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20231001,
			frame = 58,
			sound = {
				"20200_xp1"
			}
		},
		{
			behitted = "hitdown",
			id = 20231002,
			frame = 76,
			sound = {
				"20200_xp2"
			},
			shake = {
				x = 0,
				y = 6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect2 = {
	totalframe = 95,
	bgfile = "20200_bg",
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
			texture = "role/20202.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 59,
			timescale = 0.2
		},
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 32,
				startframe = 38
			},
			{
				scale = 1.2,
				totalframe = 10,
				startframe = 74
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 50,
				startframe = 38,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp2 = {
	turnbacklimit = true,
	xpeffect = "xp_effect2",
	totalframe = 97,
	animation = "xp",
	action_on_start = {
		{
			startframe = 36,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 3,
						posx = 80
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 20232001,
			frame = 39,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 40,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 45,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 49,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 50,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20232001,
			frame = 58,
			sound = {
				"20200_xp1"
			}
		},
		{
			behitted = "hitdown",
			id = 20232002,
			frame = 76,
			sound = {
				"20200_xp2"
			},
			shake = {
				x = 0,
				y = 6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect3 = {
	totalframe = 95,
	bgfile = "20200_bg",
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
			texture = "role/20204.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 59,
			timescale = 0.2
		},
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 32,
				startframe = 38
			},
			{
				scale = 1.2,
				totalframe = 10,
				startframe = 74
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 50,
				startframe = 38,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp3 = {
	turnbacklimit = true,
	xpeffect = "xp_effect3",
	totalframe = 97,
	animation = "xp",
	action_on_start = {
		{
			startframe = 36,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 3,
						posx = 80
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 20234001,
			frame = 39,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20234001,
			frame = 40,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20234001,
			frame = 45,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20234001,
			frame = 49,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20234001,
			frame = 50,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20234001,
			frame = 58,
			sound = {
				"20200_xp1"
			}
		},
		{
			behitted = "hitdown",
			id = 20234002,
			frame = 76,
			shake = {
				x = 0,
				y = 6
			},
			sound = {
				"20200_xp2"
			}
		}
	}
}
var_0_0.xpeffect.xp_effect4 = {
	totalframe = 95,
	bgfile = "20200_bg",
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
			texture = "role/20210.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 59,
			timescale = 0.2
		},
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 32,
				startframe = 38
			},
			{
				scale = 1.2,
				totalframe = 10,
				startframe = 74
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 50,
				startframe = 38,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp4 = {
	turnbacklimit = true,
	xpeffect = "xp_effect4",
	totalframe = 97,
	animation = "xp",
	action_on_start = {
		{
			startframe = 36,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 3,
						posx = 80
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 20240001,
			frame = 39,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20240001,
			frame = 40,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20240001,
			frame = 45,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20240001,
			frame = 49,
			sound = {
				"20200_xp1"
			}
		},
		{
			frame = 50,
			id = 20240001,
			sound = {
				"20200_xp1"
			}
		},
		{
			id = 20240001,
			frame = 58,
			sound = {
				"20200_xp1"
			}
		},
		{
			behitted = "hitdown",
			id = 20240002,
			frame = 76,
			shake = {
				x = 0,
				y = 6
			},
			sound = {
				"20200_xp2"
			}
		}
	}
}

return var_0_0
