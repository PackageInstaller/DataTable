return {
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200100-attack",
					0.6
				}
			},
			{
				id = 20010001,
				frame = 12,
				effect = {
					{
						ani = "attack",
						name = "20000_effect",
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
				frame = 1,
				sound = {
					"200100-attack",
					0.6
				}
			},
			{
				id = 20010001,
				frame = 10,
				effect = {
					{
						ani = "attack2",
						name = "20000_effect",
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
				frame = 1,
				sound = {
					"200100-attack",
					0.6
				}
			},
			{
				id = 20010001,
				frame = 11
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
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200200-skill",
					0.6
				}
			},
			{
				id = 20020001,
				frame = 14
			},
			{
				id = 20020001,
				frame = 18
			},
			{
				id = 20020001,
				frame = 22
			}
		}
	},
	useskill3 = {
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200200-skill",
					0.6
				}
			},
			{
				id = 20020101,
				frame = 14
			},
			{
				id = 20020101,
				frame = 18
			},
			{
				id = 20020101,
				frame = 22
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "xp_begin1"
			}
		}
	},
	xp2 = {
		{
			{
				method = "useSkill",
				param = "xp_begin2"
			}
		}
	},
	xp3 = {
		{
			{
				method = "useSkill",
				param = "xp_begin3"
			}
		}
	},
	xp4 = {
		{
			{
				method = "useSkill",
				param = "xp_begin4"
			}
		}
	},
	xp5 = {
		{
			{
				method = "useSkill",
				param = "xp_begin5"
			}
		}
	},
	xp6 = {
		{
			{
				method = "useSkill",
				param = "xp_begin6"
			}
		}
	},
	xp7 = {
		{
			{
				method = "useSkill",
				param = "xp_begin7"
			}
		}
	},
	xp8 = {
		{
			{
				method = "useSkill",
				param = "xp_begin8"
			}
		}
	},
	xp9 = {
		{
			{
				method = "useSkill",
				param = "xp_begin9"
			}
		}
	},
	xp10 = {
		{
			{
				method = "useSkill",
				param = "xp_begin10"
			}
		}
	},
	xp11 = {
		{
			{
				method = "useSkill",
				param = "xp_begin11"
			}
		}
	},
	xp12 = {
		{
			{
				method = "useSkill",
				param = "xp_begin12"
			}
		}
	},
	xp13 = {
		{
			{
				method = "useSkill",
				param = "xp_begin13"
			}
		}
	},
	xp_begin = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20004.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 400,
					time = 0.33
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end"
			}
		}
	},
	xp_end = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin1 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20001.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack1"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack1 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense1"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense1 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 310,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end1"
			}
		}
	},
	xp_end1 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin2 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20001.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack2"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack2 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense2"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense2 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 322,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end2"
			}
		}
	},
	xp_end2 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin3 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20001.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack3"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack3 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense3"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense3 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 334,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end3"
			}
		}
	},
	xp_end3 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin4 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20001.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack4"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack4 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense4"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense4 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 346,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end4"
			}
		}
	},
	xp_end4 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin5 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20001.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack5"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack5 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense5"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense5 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 370,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end5"
			}
		}
	},
	xp_end5 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin6 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20004.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack6"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack6 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense6"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense6 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 250,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end6"
			}
		}
	},
	xp_end6 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20034001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin7 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20004.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack7"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack7 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense7"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense7 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 250,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end7"
			}
		}
	},
	xp_end7 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20034101,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin8 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20004.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack8"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack8 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense8"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense8 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 250,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end8"
			}
		}
	},
	xp_end8 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20034201,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin9 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20004.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack9"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack9 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense9"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense9 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 250,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end9"
			}
		}
	},
	xp_end9 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20034301,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin10 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20004.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack10"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack10 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense10"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense10 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 250,
					time = 0.2
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end10"
			}
		}
	},
	xp_end10 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20034401,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin11 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20002.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack11"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack11 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense11"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense11 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 400,
					time = 0.33
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end11"
			}
		}
	},
	xp_end11 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin12 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20003.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack12"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack12 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense12"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense12 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 400,
					time = 0.33
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end12"
			}
		}
	},
	xp_end12 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	xp_begin13 = {
		totalframe = 30,
		turnbacklimit = true,
		nextani = true,
		animation = "xp_begin",
		lock_screen = {
			texture = "role/xp/20005.png",
			lastframe = 30,
			file = "xp",
			startframe = 0,
			ani = "xp_200"
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack13"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"200300-xp",
					0.6
				}
			}
		}
	},
	xp_attack13 = {
		turnbacklimit = true,
		totalframe = 20,
		nextani = true,
		animation = "xp_defense",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_defense13"
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20030002
			}
		}
	},
	xp_defense13 = {
		exe_crash_type = "carry",
		turnbacklimit = true,
		exe_type = "crash",
		totalframe = 10,
		nextani = true,
		animation = "xp_attack",
		action_on_start = {
			{
				method = "rush_forward",
				param = {
					distance = 400,
					time = 0.33
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_end13"
			}
		}
	},
	xp_end13 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "xp_end",
		exe_tbl = {
			{
				behitted = "hit",
				id = 20030001,
				sound = "20000_attack",
				frame = 3,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	}
}
