local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450100-attack",
					0.6
				}
			},
			{
				frame = 13,
				id = 10020521,
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 14,
				id = 10020523
			},
			{
				frame = 15,
				id = 10020524
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450100-attack",
					0.6
				}
			},
			{
				frame = 13,
				id = 10020521,
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 14,
				id = 10020523
			},
			{
				frame = 15,
				id = 10020524
			}
		}
	},
	attack3 = {
		totalframe = 20,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450100-attack",
					0.6
				}
			},
			{
				frame = 13,
				id = 10020522,
				effect = {
					{
						ani = "attack2",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 14,
				id = 10020523
			},
			{
				frame = 15,
				id = 10020524
			}
		}
	},
	attack4 = {
		totalframe = 20,
		animation = "attack4",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450100-attack",
					0.6
				}
			},
			{
				frame = 13,
				id = 10020522,
				effect = {
					{
						ani = "attack2",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 14,
				id = 10020523
			},
			{
				frame = 15,
				id = 10020524
			}
		}
	},
	attack_fly = {
		totalframe = 20,
		animation = "attack_air",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450100-attack",
					0.6
				}
			},
			{
				frame = 13,
				id = 10020521,
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
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
	skill1_fly = {
		{
			{
				method = "useSkill",
				param = "useskill1_fly"
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
	skill2_fly = {
		{
			{
				method = "useSkill",
				param = "useskill2_fly"
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
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	useskill1 = {
		totalframe = 18,
		animation = "skill1_run_1",
		exe_tbl = {
			{
				id = 10020531,
				frame = 30
			}
		}
	},
	useskill2 = {
		totalframe = 20,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10020541,
				frame = 0
			}
		}
	},
	useskill2_fly = {
		totalframe = 20,
		animation = "skill2_fly",
		exe_tbl = {
			{
				id = 10020541,
				frame = 0
			}
		}
	},
	useskill3 = {
		totalframe = 94,
		animation = "skill4",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "change_to_invincible"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "remove_invincible"
			},
			{
				method = "complete"
			}
		},
		exe_tbl = {
			{
				frame = 77,
				behitted = "hitdown",
				id = 10020551
			}
		}
	},
	usexp = {
		totalframe = 159,
		animation = "xp",
		xpeffect = {
			conf = "xp_effect",
			startframe = 0
		},
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 58,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 800
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 0,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 70,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 0,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				frame = 71,
				sound = "100461_xp"
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 80,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 88,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 98,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 104,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 112,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 121,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 130,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			},
			{
				behitted = "hitdown",
				id = 10020561,
				frame = 147,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				forceY = {
					speed = 200
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = -50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "100200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 30
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 159,
	bgfile = "100100_bg",
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
			texture = "role/100200.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
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
