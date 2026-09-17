local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 32,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28020_attack",
					0.6
				}
			},
			{
				id = 28010010,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "28020_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
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
		skillattackframe = 30,
		totalframe = 35,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28020_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 28020010,
				frame = 20,
				effect = {
					{
						ani = "skill",
						name = "28020_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 600
					}
				}
			},
			{
				id = 280601012,
				frame = 25,
				forceY = {
					{
						distance = 100,
						time = 1.25
					}
				}
			},
			{
				frame = 25,
				id = 280601011
			}
		}
	},
	usexp = {
		totalframe = 95,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28020_xp",
					0.6
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 24,
				forceY = {
					{
						speed = 300
					}
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 30,
				forceY = {
					{
						speed = 300
					}
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 36,
				forceY = {
					{
						speed = 300
					}
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 46,
				forceY = {
					{
						speed = 300
					}
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 54,
				forceY = {
					{
						speed = 300
					}
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 60,
				forceY = {
					{
						speed = 300
					}
				}
			},
			{
				behitted = "hitdown",
				id = 28030010,
				frame = 69,
				forceY = {
					{
						speed = 500
					}
				},
				shake = {
					x = 0,
					y = 40
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 72,
				forceY = {
					{
						speed = 400
					}
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 79,
				forceY = {
					{
						speed = 400
					}
				}
			},
			{
				id = 28030010,
				behitted = "hitdown",
				frame = 85,
				forceY = {
					{
						speed = 400
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
	bgfile = "28020_bg",
	locktarget = {
		mindistance = 200,
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/28020.png",
			ani = "xp2",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/28020_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 65,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 50,
				startframe = 15
			}
		},
		move = {}
	}
}

return var_0_0
