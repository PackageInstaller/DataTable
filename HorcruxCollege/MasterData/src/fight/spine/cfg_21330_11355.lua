local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 24,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				bullet = "attack",
				sound = {
					"21200_attack",
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
		skillattackframe = 45,
		totalframe = 49,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 213320010,
				effect = {
					{
						ani = "skill1",
						name = "121355_21300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_attack",
					0.6
				}
			},
			{
				frame = 31,
				id = 213320011
			},
			{
				frame = 32,
				id = 213320012
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
	useskill2 = {
		skillattackframe = 45,
		totalframe = 49,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 213320010,
				effect = {
					{
						ani = "skill1",
						name = "121355_21300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_attack",
					0.6
				}
			},
			{
				frame = 31,
				id = 213320011
			},
			{
				frame = 32,
				id = 213320012
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
		totalframe = 49,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 213320010,
				effect = {
					{
						ani = "skill1",
						name = "121355_21300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_attack",
					0.6
				}
			},
			{
				frame = 31,
				id = 213320011
			},
			{
				frame = 32,
				id = 213320012
			}
		}
	},
	skill2_1 = {
		{
			{
				method = "useSkill",
				param = "useskill2_1"
			}
		}
	},
	useskill2_1 = {
		totalframe = 49,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 213320010,
				effect = {
					{
						ani = "skill1",
						name = "121355_21300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_attack",
					0.6
				}
			},
			{
				frame = 31,
				id = 213320011
			},
			{
				frame = 32,
				id = 213320012
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
		totalframe = 49,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 213320010,
				effect = {
					{
						ani = "skill1",
						name = "121355_21300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_attack",
					0.6
				}
			},
			{
				frame = 31,
				id = 213320011
			},
			{
				frame = 32,
				id = 213320012
			}
		}
	},
	skill2_2 = {
		{
			{
				method = "useSkill",
				param = "useskill2_2"
			}
		}
	},
	useskill2_2 = {
		totalframe = 49,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21200_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 213320010,
				effect = {
					{
						ani = "skill1",
						name = "121355_21300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21200_attack",
					0.6
				}
			},
			{
				frame = 31,
				id = 213320011
			},
			{
				frame = 32,
				id = 213320012
			}
		}
	},
	xp = {
		{
			{
				param = 0.5,
				operator = "<=",
				method = "check_target_hp_percent"
			},
			{
				method = "useSkill",
				param = "usexp1"
			}
		},
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	usexp = {
		totalframe = 70,
		xpeffect = "xp_effect1",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "21320_xp"
			},
			{
				frame = 24,
				effect = {
					{
						ani = "xp_attack",
						name = "121355_21300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 48,
				bullet = "xp",
				shake = {
					x = 4,
					y = 15
				}
			}
		}
	},
	usexp1 = {
		totalframe = 70,
		xpeffect = "xp_effect1",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "21320_xp"
			},
			{
				frame = 24,
				effect = {
					{
						ani = "xp_attack",
						name = "121355_21300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 48,
				bullet = "xp1",
				shake = {
					x = 4,
					y = 15
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect1 = {
	totalframe = 69,
	bgfile = "21300_bg",
	locktarget = {
		mindistance = 400,
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
			texture = "role/21320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21320_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 51,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 25,
				startframe = 0
			},
			{
				scale = 0.8,
				totalframe = 35,
				startframe = 30
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 40,
				startframe = 0,
				time = 0.1
			},
			{
				pos = "target",
				totalframe = 30,
				startframe = 40,
				time = 0.5
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "121355_21300_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.3,
		offsetX = 0.75,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 213310010,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 800,
	movingtype = "locktime",
	speed = 1500,
	offsetZ = 1,
	filename = "121355_21300_effect",
	size = {
		width = 80,
		height = 100
	},
	initpos = {
		offsetY = 0.3,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		time = 0.1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 0,
				id = 213330010,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			},
			{
				frame = 1,
				id = 213330011
			},
			{
				frame = 2,
				id = 213330012
			}
		}
	}
}
var_0_0.extra.xp1 = {
	movingani = "xp_run",
	maxdistance = 800,
	movingtype = "locktime",
	speed = 1500,
	offsetZ = 1,
	filename = "121355_21300_effect",
	size = {
		width = 80,
		height = 100
	},
	initpos = {
		offsetY = 0.3,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		time = 0.1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 0,
				id = 213330010,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			},
			{
				frame = 1,
				id = 213330011
			},
			{
				frame = 2,
				id = 213330012
			}
		}
	}
}

return var_0_0
