local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 15,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"420100-attack",
					0.6
				}
			},
			{
				frame = 8,
				id = 42910001,
				effect = {
					{
						ani = "attack",
						name = "42000_effect",
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
		totalframe = 15,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"420100-attack",
					0.6
				}
			},
			{
				frame = 8,
				id = 42910001,
				effect = {
					{
						ani = "attack",
						name = "42000_effect",
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
		totalframe = 15,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"420100-attack",
					0.6
				}
			},
			{
				frame = 8,
				id = 42910001,
				effect = {
					{
						ani = "attack",
						name = "42000_effect",
						offsetZ = 1,
						offsetY = 0.5,
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
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
		totalframe = 20,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"420200-skill1",
					0.6
				}
			},
			{
				frame = 12,
				id = 42920001,
				effect = {
					{
						ani = "attack",
						name = "42000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 100,
		exe_type = "crash",
		totalframe = 25,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 7,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 150,
							time = 0.3
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"420210-skill2",
					0.6
				}
			},
			{
				frame = 8,
				id = 42930001,
				effect = {
					{
						ani = "attack",
						name = "42000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 42930002,
				frame = 18,
				effect = {
					{
						ani = "attack",
						name = "42000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 250,
						object = "target"
					}
				}
			}
		}
	},
	useskill3 = {
		totalframe = 32,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"420220-skill3",
					0.6
				}
			},
			{
				id = 42940001,
				frame = 25,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "42000_effect",
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
	totalframe = 47,
	bgfile = "42080_bg",
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
			texture = "role/42020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 30,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 7,
				startframe = 26
			}
		},
		move = {
			{
				distance = 250,
				time = 0.2,
				distanceY = 0,
				totalframe = 7,
				startframe = 26
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "qianyao"
		}
	}
}
var_0_0.qianyao = {
	totalframe = 22,
	nextani = true,
	animation = "win",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = -50,
						time = 0.1
					}
				}
			}
		}
	},
	xpeffect = {
		conf = "xp_effect",
		startframe = 30
	},
	exe_tbl = {
		{
			id = 44900000,
			frame = 1,
			sound = {
				"invalid",
				1.6
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 48,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 15,
			sound = {
				"420300-xp",
				0.6
			}
		},
		{
			frame = 33,
			behitted = "hitdown",
			id = 42950001,
			shake = {
				x = 2,
				y = 0
			}
		},
		{
			frame = 63,
			id = 42950002,
			shake = {
				x = 2,
				y = 0
			}
		}
	}
}

return var_0_0
