local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 37,
		animation = "attack",
		exe_tbl = {
			{
				frame = 13,
				id = 25310001,
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"25320_atk1",
					0.6
				}
			},
			{
				id = 25310002,
				frame = 27,
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
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
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
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
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1 = {
		skillattackframe = 45,
		totalframe = 50,
		animation = "skill1",
		action_on_start = {
			{
				startframe = 17,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = 50
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"25320_skill",
					0.6
				}
			},
			{
				id = 25320001,
				frame = 20,
				behitted = "hitdown",
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 750
					}
				},
				force = {
					{
						time = 0.25,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				}
			},
			{
				id = 25320002,
				frame = 35,
				behitted = "hitdown",
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = -950
					}
				},
				force = {
					{
						time = 0.25,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_1 = {
		totalframe = 50,
		animation = "skill1",
		action_on_start = {
			{
				startframe = 17,
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
				frame = 3,
				sound = {
					"25320_skill",
					0.6
				}
			},
			{
				id = 25320101,
				frame = 20,
				behitted = "hitdown",
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 750
					}
				}
			},
			{
				id = 25320101,
				frame = 35,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = -750
					}
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 50,
		animation = "skill1",
		action_on_start = {
			{
				startframe = 17,
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
				frame = 3,
				sound = {
					"25320_skill",
					0.6
				}
			},
			{
				id = 25320201,
				frame = 20,
				behitted = "hitdown",
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 750
					}
				}
			},
			{
				id = 25320201,
				frame = 35,
				behitted = "hitdown",
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = -750
					}
				}
			}
		}
	},
	useskill1_3 = {
		totalframe = 50,
		animation = "skill1",
		action_on_start = {
			{
				startframe = 17,
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
				frame = 3,
				sound = {
					"25320_skill",
					0.6
				}
			},
			{
				id = 25320301,
				frame = 20,
				behitted = "hitdown",
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 750
					}
				}
			},
			{
				id = 25320301,
				frame = 35,
				behitted = "hitdown",
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						speed = -750
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 130,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 12,
				sound = {
					"25320_xp",
					0.6
				}
			},
			{
				id = 25330001,
				frame = 37,
				shake = {
					x = 10,
					y = 0
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 25330001,
				frame = 43,
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 25330001,
				frame = 48,
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 25330001,
				frame = 53,
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 25330001,
				behitted = "hitdown",
				frame = 58,
				shake = {
					x = 0,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 25330001,
				behitted = "hitdown",
				frame = 63,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 25330001,
				behitted = "hitdown",
				frame = 68,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 25330001,
				behitted = "hitdown",
				frame = 73,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 25330002,
				frame = 93,
				behitted = "hitdown",
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.25,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			},
			{
				id = 25330003,
				frame = 94,
				shake = {
					x = 10,
					y = 10
				},
				effect = {
					{
						ani = "attack",
						name = "25320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfileflipx = true,
	totalframe = 130,
	bgfile = "25320_bg",
	locktarget = {
		locktarget = true
	},
	show = {
		{
			action = "show",
			startframe = 1,
			target = "target"
		},
		{
			action = "hide",
			startframe = 110,
			target = "target"
		}
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
			texture = "role/25340.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/25300_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 85,
			timescale = 0.3
		},
		{
			totalframe = 3,
			startframe = 95,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.6,
				totalframe = 70,
				startframe = 20
			},
			{
				scale = 1.2,
				totalframe = 7,
				startframe = 90
			},
			{
				scale = 0.6,
				totalframe = 28,
				startframe = 97
			}
		},
		move = {
			{
				distanceY = -130,
				totalframe = 70,
				startframe = 20,
				time = 0.2
			},
			{
				distance = 200,
				time = 0.3,
				distanceY = 130,
				totalframe = 10,
				startframe = 90
			}
		}
	}
}

return var_0_0
