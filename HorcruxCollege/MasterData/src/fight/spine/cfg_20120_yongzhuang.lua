local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 20110101,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 20,
						object = "target"
					}
				},
				sound = {
					"20100_attack",
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
				id = 20110101,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 20,
						object = "target"
					}
				},
				sound = {
					"20100_attack",
					0.6
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "xp_begin"
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
		totalframe = 35,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20120-skill",
					0.6
				}
			},
			{
				id = 20121001,
				behitted = "hitdown",
				frame = 20,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				}
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	useskill1_1 = {
		totalframe = 35,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20120-skill",
					0.6
				}
			},
			{
				id = 20121101,
				behitted = "hitdown",
				frame = 20,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				}
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	useskill1_2 = {
		totalframe = 35,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20120-skill",
					0.6
				}
			},
			{
				id = 20121201,
				behitted = "hitdown",
				frame = 20,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				}
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1_3 = {
		totalframe = 35,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20120-skill",
					0.6
				}
			},
			{
				id = 20121301,
				behitted = "hitdown",
				frame = 20,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				}
			}
		}
	},
	xp_begin = {
		totalframe = 81,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 14,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
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
					"20120-xp",
					1
				}
			},
			{
				frame = 18,
				behitted = "hit",
				id = 20150001,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 21,
				behitted = "hit",
				id = 20150001,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 24,
				behitted = "hit",
				id = 20150001,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 27,
				behitted = "hit",
				id = 20150001,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 30,
				behitted = "hit",
				id = 20150001,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 33,
				behitted = "hit",
				id = 20150001,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 36,
				behitted = "hit",
				id = 20150001,
				effect = {
					{
						ani = "attack",
						name = "20120_effect",
						offsetZ = 1,
						offsetY = 0.7,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 40
			},
			{
				behitted = "hitdown",
				id = 20150002,
				frame = 55,
				force = {
					{
						time = 0.3,
						shutdown = true,
						distance = 240,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 4,
					y = 20
				},
				forceY = {
					speed = 830
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 80,
	bgfile = "swim_bg",
	locktarget = {
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
			texture = "role/20120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20120_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 56,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 33,
				startframe = 13
			},
			{
				scale = 0.8,
				totalframe = 22,
				startframe = 50
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 41,
				startframe = 14,
				time = 0.1
			},
			{
				distance = 50,
				totalframe = 20,
				startframe = 55,
				time = 0.1
			}
		}
	}
}

return var_0_0
