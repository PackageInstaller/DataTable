local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"430100-attack",
					0.6
				}
			},
			{
				frame = 10,
				id = 43910001,
				effect = {
					{
						ani = "attack",
						name = "43000_effect",
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
					"430100-attack",
					0.6
				}
			},
			{
				frame = 10,
				id = 43910001,
				effect = {
					{
						ani = "attack",
						name = "43000_effect",
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
				param = "qianyao"
			}
		}
	},
	qianyao = {
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
			startframe = 23
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
		totalframe = 15,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 11,
				sound = {
					"430200-skill1",
					0.6
				}
			},
			{
				frame = 8,
				id = 43920001,
				effect = {
					{
						ani = "skill1_attack",
						name = "43000_effect",
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
		totalframe = 20,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 15,
				sound = {
					"430210-skill2",
					0.6
				}
			},
			{
				frame = 15,
				bullet = "skill2"
			}
		}
	},
	useskill3 = {
		totalframe = 20,
		animation = "skill3",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 10,
							posx = 1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"430220-skill3",
					0.6
				}
			},
			{
				id = 43940001,
				frame = 15,
				shake = {
					x = 0,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "43000_effect",
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
	totalframe = 50,
	bgfile = "43020_bg",
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
			texture = "role/43020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 31,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 22,
				startframe = 19
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 22,
				startframe = 19,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	xpeffect = "xp_effect",
	totalframe = 20,
	nextani = true,
	animation = "xp_1",
	action_on_start = {
		{
			method = "change_to_invincible"
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "usexp2"
		}
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"430300-xp",
				0.6
			}
		}
	}
}
var_0_0.usexp2 = {
	totalframe = 20,
	nextani = true,
	animation = "xp_2",
	exe_tbl = {
		{
			id = 43950001,
			frame = 5,
			shake = {
				x = 3,
				y = 0
			},
			effect = {
				{
					ani = "attack",
					name = "43000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"20200_attack"
			}
		},
		{
			id = 43950001,
			frame = 12,
			shake = {
				x = 3,
				y = 0
			},
			effect = {
				{
					ani = "attack",
					name = "43000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"20200_attack"
			}
		},
		{
			id = 43950001,
			frame = 16,
			shake = {
				x = 3,
				y = 0
			},
			effect = {
				{
					ani = "attack",
					name = "43000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"20200_attack"
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "usexp3"
		}
	}
}
var_0_0.usexp3 = {
	totalframe = 11,
	animation = "xp_3",
	action_on_start = {
		{
			method = "remove_invincible"
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill2_run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 200,
	offsetZ = 1,
	filename = "43000_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 43930001,
				frame = 0
			}
		}
	}
}

return var_0_0
