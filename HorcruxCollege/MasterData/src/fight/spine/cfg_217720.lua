local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack",
				sound = {
					"20400_attack",
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
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22620_skill",
					0.6
				}
			},
			{
				id = 217720010,
				frame = 18
			},
			{
				id = 217720010,
				frame = 18
			},
			{
				id = 217720010,
				frame = 18
			},
			{
				id = 217720010,
				frame = 19
			},
			{
				id = 217720010,
				frame = 20
			},
			{
				id = 217720010,
				frame = 21
			},
			{
				id = 217720010,
				frame = 22
			},
			{
				id = 217720010,
				frame = 23
			},
			{
				id = 217720010,
				frame = 24
			},
			{
				id = 217720010,
				frame = 25
			},
			{
				id = 217720011,
				frame = 26
			},
			{
				id = 217720012,
				frame = 27
			}
		}
	},
	usexp = {
		totalframe = 105,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				id = 217730010,
				frame = 42,
				shake = {
					x = 2,
					y = 5
				},
				sound = {
					"22620_xp1"
				}
			},
			{
				id = 217730010,
				frame = 47,
				shake = {
					x = 2,
					y = 5
				}
			},
			{
				id = 217730010,
				frame = 54,
				shake = {
					x = 2,
					y = 5
				}
			},
			{
				id = 217730010,
				frame = 60,
				shake = {
					x = 2,
					y = 5
				}
			},
			{
				id = 217730010,
				frame = 78,
				shake = {
					x = 2,
					y = 5
				}
			},
			{
				id = 217730010,
				frame = 81,
				shake = {
					x = 3,
					y = 5
				}
			},
			{
				id = 217730010,
				frame = 85,
				shake = {
					x = 3,
					y = 5
				}
			},
			{
				id = 217730010,
				frame = 89,
				shake = {
					x = 3,
					y = 5
				}
			},
			{
				behitted = "hitdown",
				id = 217730010,
				frame = 96,
				shake = {
					x = 4,
					y = 6
				}
			},
			{
				behitted = "hitdown",
				id = 217730010,
				frame = 96,
				shake = {
					x = 4,
					y = 6
				}
			},
			{
				behitted = "hitdown",
				id = 217730012,
				frame = 96,
				shake = {
					x = 4,
					y = 6
				}
			},
			{
				behitted = "hitdown",
				id = 217730011,
				frame = 97,
				shake = {
					x = 4,
					y = 6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 105,
	bgfile = "217720_bg",
	locktarget = {
		mindistance = 150,
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
			texture = "role/217720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22620_xp",
				1
			}
		}
	},
	bgaction = {
		{
			param = 0,
			startframe = 27,
			action = "setZOrder"
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 74,
			timescale = 0.2
		},
		{
			totalframe = 3,
			startframe = 96,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 1.3,
				anchory = 200,
				outtime = 0.1,
				totalframe = 35,
				intime = 0.2
			},
			{
				startframe = 27,
				scale = 1,
				anchory = 300,
				outtime = 0.3,
				totalframe = 65,
				intime = 0.2
			},
			{
				startframe = 96,
				scale = 1,
				anchory = 300,
				outtime = 0.2,
				totalframe = 23,
				intime = 0.6
			}
		},
		move = {
			{
				distanceY = 50,
				totalframe = 27,
				startframe = 0,
				time = 0.1
			},
			{
				distance = 110,
				totalframe = 75,
				startframe = 27,
				time = 0.2
			},
			{
				distanceY = -50,
				totalframe = 59,
				startframe = 40,
				time = 0.6
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "217720_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 217710010
			}
		}
	}
}

return var_0_0
