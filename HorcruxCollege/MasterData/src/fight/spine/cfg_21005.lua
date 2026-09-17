local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 21010001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21000_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 21010001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21000_attack",
					0.6
				}
			}
		}
	},
	attack3 = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 21010001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21000_attack",
					0.6
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
	useskill1 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21000_skill",
					0.6
				}
			},
			{
				id = 21020001,
				frame = 17
			},
			{
				frame = 30,
				behitted = "hit",
				id = 21020001
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21000_skill",
					0.6
				}
			},
			{
				id = 21020101,
				frame = 17
			},
			{
				frame = 30,
				behitted = "hit",
				id = 21020101
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21000_skill",
					0.6
				}
			},
			{
				id = 21020201,
				frame = 17
			},
			{
				frame = 30,
				behitted = "hit",
				id = 21020201
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21000_skill",
					0.6
				}
			},
			{
				id = 21020301,
				frame = 17
			},
			{
				frame = 30,
				behitted = "hit",
				id = 21020301
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "xp_begin1"
			}
		}
	},
	xp_begin1 = {
		xpeffect = "xp_effect",
		totalframe = 5,
		nextani = true,
		animation = "xp_begin",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21000_xp1"
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_begin"
			}
		}
	},
	xp_begin = {
		turnbacklimit = true,
		exe_type = "cross",
		totalframe = 40,
		nextani = true,
		action_on_start = {
			{
				startframe = 38,
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
				id = 21035001,
				frame = 39,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
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
						distance = 60,
						object = "target"
					}
				},
				forceY = {
					speed = 400
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack"
			}
		}
	},
	xp_attack = {
		totalframe = 49,
		animation = "xp_attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21000_xp2"
				}
			},
			{
				frame = 8,
				id = 21035001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 16,
				id = 21035001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 24,
				id = 21035001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 32,
				id = 21035001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 40,
				id = 21035001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
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
	totalframe = 86,
	bgfile = "21000_bg",
	locktarget = {
		mindistance = 250,
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
			texture = "role/21005.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21020_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 29,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 26,
				startframe = 4
			}
		}
	}
}

return var_0_0
