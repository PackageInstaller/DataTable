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
					"huiwu",
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
					"huiwu",
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
					"huiwu",
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
		turnbacklimit = true,
		totalframe = 53,
		animation = "skill",
		action_on_start = {
			{
				exe_type = "crash",
				exe_crash_bound = 75,
				exe_crash_type = "carry",
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
					"huiwu",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 78,
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
					"xp",
					0.6
				}
			},
			{
				frame = 33,
				id = 22930001,
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
					"huiwu",
					0.6
				}
			},
			{
				frame = 38,
				id = 22930001,
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
					"huiwu",
					0.6
				}
			},
			{
				frame = 44,
				id = 22930001,
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
					"huiwu",
					0.6
				}
			},
			{
				frame = 50,
				id = 22930001,
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
					"huiwu",
					0.6
				}
			},
			{
				id = 22930002,
				frame = 65,
				behitted = "hit",
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
					x = 4,
					y = 2
				},
				sound = {
					"huiwu",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 78,
	bgfile = "22900_bg",
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
			texture = "role/22910.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
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
				scale = 1.2,
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
var_0_0.usexp1 = {
	totalframe = 77,
	xpeffect = "xp_effect1",
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
				"xp",
				0.6
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
				"huiwu",
				0.6
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
				"huiwu",
				0.6
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
				"huiwu",
				0.6
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
				"huiwu",
				0.6
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
				x = 4,
				y = 2
			},
			sound = {
				"huiwu",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 77,
	bgfile = "22900_bg",
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
			texture = "role/22910.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
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
