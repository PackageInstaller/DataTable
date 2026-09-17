local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"480100-attack",
					0.6
				}
			},
			{
				frame = 11,
				bullet = "attack"
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
		totalframe = 25,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"480200-skill1",
					0.6
				}
			},
			{
				id = 48020001,
				frame = 18,
				shake = {
					x = 0,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "48000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 48020001,
				frame = 19,
				shake = {
					x = 0,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "48000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 48020001,
				frame = 22,
				shake = {
					x = 0,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "48000_effect",
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
		totalframe = 25,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"480210-skill2",
					0.6
				}
			},
			{
				frame = 8,
				bullet = "skill2"
			}
		}
	},
	useskill3 = {
		totalframe = 25,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"480220-skill3",
					0.6
				}
			},
			{
				id = 48022001,
				frame = 12,
				shake = {
					x = 6,
					y = 0
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 66,
	bgfile = "48000_bg",
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
			texture = "role/48000.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 54,
				startframe = 10
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 54,
				startframe = 10,
				time = 0.1
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
	totalframe = 67,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 13,
			sound = {
				"480300-xp",
				0.6
			}
		},
		{
			frame = 19,
			bullet = "xp"
		},
		{
			frame = 33,
			bullet = "xp"
		},
		{
			frame = 47,
			bullet = "xp"
		},
		{
			frame = 61,
			bullet = "xp"
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "48000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 48010001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill2_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "48000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "skill2_attack",
		exe_tbl = {
			{
				id = 48021001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "48000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 48030001,
				frame = 1
			}
		}
	}
}

return var_0_0
