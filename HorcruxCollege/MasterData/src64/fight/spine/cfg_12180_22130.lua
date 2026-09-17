local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				id = 221310010,
				frame = 14,
				effect = {
					{
						ani = "attack",
						name = "12180_22130_effect",
						offsetZ = 1,
						offsetY = 0.5,
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
		skillattackframe = 45,
		totalframe = 48,
		turnbacklimit = true,
		animation = "skill",
		action_on_start = {
			{
				startframe = 10,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.4
						}
					}
				}
			},
			{
				startframe = 26,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -100,
							time = 0.25
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_skill",
					0.6
				}
			},
			{
				frame = 10,
				id = 221320010
			},
			{
				id = 221320011,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "12180_22130_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			},
			{
				id = 221320011,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "12180_22130_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			},
			{
				id = 221320011,
				frame = 30,
				effect = {
					{
						ani = "attack",
						name = "12180_22130_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			},
			{
				frame = 40,
				id = 221320012
			},
			{
				frame = 41,
				id = 221320013
			}
		}
	},
	usexp = {
		totalframe = 51,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 30,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = 100
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_xp1"
				}
			},
			{
				id = 221330010,
				frame = 34,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "12180_22130_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						distance = -25,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 500
					}
				},
				shake = {
					time = 0.2,
					x = 4,
					y = 8
				}
			},
			{
				frame = 35,
				id = 221330011
			},
			{
				frame = 40,
				id = 221330012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 51,
	bgfile = "2019shengdan_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/22130.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22120_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 28,
			timescale = 0.2
		},
		{
			totalframe = 6,
			startframe = 34.5,
			timescale = 0.15
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				intime = 0.15,
				anchory = 0,
				outtime = 0.1,
				totalframe = 10,
				startframe = 0
			},
			{
				scale = 0.8,
				intime = 0.15,
				anchory = 0,
				outtime = 0.01,
				totalframe = 17,
				startframe = 16
			},
			{
				scale = 0.9,
				intime = 0.1,
				anchory = 0,
				totalframe = 10,
				startframe = 33
			}
		},
		move = {
			{
				distance = 70,
				totalframe = 30,
				startframe = 0,
				time = 0.1
			},
			{
				distanceY = 50,
				totalframe = 17,
				startframe = 10,
				time = 0.3
			},
			{
				pos = "target",
				totalframe = 20,
				startframe = 31,
				time = 0.1
			},
			{
				distanceY = -100,
				totalframe = 10,
				startframe = 33,
				time = 0.1
			},
			{
				distanceY = 50,
				totalframe = 1,
				startframe = 43,
				time = 0.3
			}
		}
	}
}

return var_0_0
