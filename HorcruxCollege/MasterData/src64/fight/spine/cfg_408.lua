local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 15,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 8,
				id = 40010091,
				effect = {
					{
						ani = "attack",
						name = "40000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"400100-attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 15,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 8,
				id = 40010091,
				effect = {
					{
						ani = "attack",
						name = "40000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"400100-attack",
					0.6
				}
			}
		}
	},
	attack3 = {
		totalframe = 15,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 8,
				id = 40010091,
				effect = {
					{
						ani = "attack",
						name = "40000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"400100-attack",
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
	skill4 = {
		{
			{
				method = "useSkill",
				param = "useskill4"
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
					"400200-skill1",
					0.6
				}
			},
			{
				frame = 12,
				bullet = "skill1"
			}
		}
	},
	useskill2 = {
		totalframe = 15,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"400210-skill2",
					0.6
				}
			},
			{
				id = 40021091,
				frame = 8
			}
		}
	},
	useskill3 = {
		totalframe = 25,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"400220-skill3",
					0.6
				}
			},
			{
				frame = 17,
				id = 40022091,
				effect = {
					{
						ani = "attack",
						name = "40000_effect",
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
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 38,
	bgfile = "40000_bg",
	locktarget = {
		mindistance = 220,
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
			texture = "role/40000.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 20,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 25,
				startframe = 10
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 25,
				startframe = 10,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	xpeffect = "xp_effect",
	totalframe = 39,
	animation = "xp",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "add_anti_hitdown"
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"400300-xp"
			}
		},
		{
			frame = 22,
			id = 40010091,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20400_attack"
			}
		},
		{
			frame = 24,
			id = 40010091,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20400_attack"
			}
		},
		{
			frame = 26,
			id = 40010091,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20400_attack"
			}
		},
		{
			frame = 28,
			id = 40030091,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20400_attack"
			}
		}
	},
	action_on_complete = {
		{
			method = "remove_anti_hitdown"
		},
		{
			method = "complete"
		}
	}
}
var_0_0.useskill4 = {
	totalframe = 39,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"400300-xp"
			}
		},
		{
			frame = 22,
			id = 40010091,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20400_attack"
			}
		},
		{
			frame = 24,
			id = 40010091,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20400_attack"
			}
		},
		{
			frame = 26,
			id = 40010091,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20400_attack"
			}
		},
		{
			frame = 28,
			id = 40039091,
			shake = {
				x = 4,
				y = 4
			},
			sound = {
				"20400_attack"
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "40000_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 40010091,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill1_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "40000_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill1_attack",
		exe_tbl = {
			{
				id = 40020091,
				frame = 1
			}
		}
	}
}

return var_0_0
