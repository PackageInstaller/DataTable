local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				id = 20110010,
				frame = 11,
				effect = {
					{
						ani = "attack",
						name = "20130_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				frame = 15,
				id = 20110011
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 20110010,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "20130_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				},
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				frame = 16,
				id = 20110011
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
		totalframe = 110,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "add_anti_hitdown"
					}
				}
			},
			{
				startframe = 5,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 50,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20130_skill",
					0.6
				}
			},
			{
				id = 20120010,
				frame = 15,
				forceY = {
					{
						time = 0.2,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				}
			},
			{
				id = 20120010,
				frame = 40,
				forceY = {
					{
						time = 0.2,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				}
			},
			{
				id = 20120010,
				frame = 60,
				forceY = {
					{
						time = 0.2,
						shutdown = false,
						distance = 60,
						object = "target"
					}
				}
			},
			{
				id = 20120011,
				behitted = "hitdown",
				frame = 90,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 80,
						object = "target"
					}
				}
			},
			{
				frame = 91,
				forceY = {
					{
						time = 0.2,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				}
			}
		}
	},
	xp_begin = {
		exe_crash_type = "carry",
		animation = "xp",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 60,
		nextani = true,
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "add_anti_hitdown"
					}
				}
			},
			{
				startframe = 40,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 150,
							time = 0.5
						}
					}
				}
			}
		},
		xpeffect = {
			conf = "xp_effect",
			startframe = 60
		},
		exe_tbl = {
			{
				frame = 1
			},
			{
				frame = 59,
				id = 20130011
			}
		},
		action_on_complete = {
			{
				method = "remove_anti_hitdown"
			},
			{
				method = "useSkill",
				param = "xp_attack"
			}
		}
	},
	xp_attack = {
		totalframe = 102,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20130_xp",
					0.6
				}
			},
			{
				frame = 25,
				id = 20130010
			},
			{
				frame = 30,
				id = 20130010
			},
			{
				frame = 35,
				id = 20130010
			},
			{
				frame = 40,
				id = 20130010
			},
			{
				id = 20130013,
				behitted = "hitdown",
				frame = 82
			},
			{
				id = 20130012,
				frame = 83,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.9,
	totalframe = 102,
	bgfile = "20130_bg",
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
			texture = "role/20104.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20104_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 4,
			startframe = 80,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.85,
				totalframe = 50,
				startframe = 1
			},
			{
				scale = 1.2,
				totalframe = 50,
				startframe = 50
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 100,
				startframe = 2,
				time = 0
			}
		}
	}
}

return var_0_0
