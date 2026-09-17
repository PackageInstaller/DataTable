local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 22910001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"22900_attack",
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
				id = 22910001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"22900_attack",
					0.6
				}
			}
		}
	},
	attack3 = {
		totalframe = 22,
		animation = "attack3",
		exe_tbl = {
			{
				id = 22910001,
				frame = 11,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"22900_attack",
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
		skillattackframe = 45,
		totalframe = 53,
		exe_crash_type = "carry",
		animation = "skill",
		exe_crash_bound = 80,
		exe_type = "crash",
		turnbacklimit = true,
		action_on_start = {
			{
				startframe = 24,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 110,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 22920001,
				frame = 27,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 0
				},
				sound = {
					"22900_skill",
					0.6
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
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 75,
		exe_type = "crash",
		totalframe = 53,
		animation = "skill",
		action_on_start = {
			{
				startframe = 24,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.15
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 22920101,
				frame = 27,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 0
				},
				sound = {
					"22900_skill",
					0.6
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
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 75,
		exe_type = "crash",
		totalframe = 53,
		animation = "skill",
		action_on_start = {
			{
				startframe = 24,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 120,
							time = 0.15
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 22920201,
				frame = 27,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 0
				},
				sound = {
					"22900_skill",
					0.6
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
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 75,
		exe_type = "crash",
		totalframe = 53,
		animation = "skill",
		action_on_start = {
			{
				startframe = 24,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 140,
							time = 0.15
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 22920301,
				frame = 27,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 0
				},
				sound = {
					"22900_skill",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 77,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 19,
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
					"22900_xp"
				}
			},
			{
				frame = 33,
				id = 22950001,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 0
				},
				sound = {
					"20200_attack"
				}
			},
			{
				frame = 38,
				id = 22950001,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 0
				},
				sound = {
					"20200_attack"
				}
			},
			{
				frame = 44,
				id = 22950001,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 0
				},
				sound = {
					"20200_attack"
				}
			},
			{
				frame = 50,
				id = 22950001,
				effect = {
					{
						ani = "attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 0
				},
				sound = {
					"20200_attack"
				}
			},
			{
				id = 22950002,
				frame = 65,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill2_attack",
						name = "22900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 6
				},
				sound = {
					"20800_skill"
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 77,
	bgfile = "22900_bg",
	bgfileflipX = true,
	locktarget = {
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
			texture = "role/22910.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22920_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 66,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 11,
				startframe = 59,
				outtime = 0.2
			}
		},
		move = {
			{
				distance = 250,
				totalframe = 13,
				startframe = 57,
				time = 0.1
			}
		}
	}
}

return var_0_0
