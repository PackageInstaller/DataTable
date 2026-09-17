local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 9,
				bullet = "attack",
				sound = {
					"nengliang",
					0.4
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
		totalframe = 44,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 11,
				id = 60320001,
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"nengliang",
					0.4
				}
			},
			{
				id = 60320001,
				frame = 20,
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"nengliang",
					0.4
				}
			},
			{
				id = 60320001,
				frame = 28,
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"nengliang",
					0.4
				}
			},
			{
				id = 60320001,
				frame = 36,
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"nengliang",
					0.4
				}
			}
		}
	},
	useskill2 = {
		totalframe = 28,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 12,
				bullet = "skill2",
				sound = {
					"nengliang",
					0.4
				}
			}
		}
	},
	useskill3 = {
		totalframe = 28,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 12,
				bullet = "skill3",
				sound = {
					"nengliang",
					0.4
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 60,
	bgfile = "47000_bg",
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
			texture = "role/60300.png",
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
				totalframe = 25,
				startframe = 30
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 25,
				startframe = 30,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 61,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 40,
			id = 60330001,
			shake = {
				x = 4,
				y = 8
			},
			sound = {
				"nengliang",
				0.4
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "60300_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
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
				frame = 1,
				id = 60310001
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "60300_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0.25,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 1,
		animation = "run",
		exe_tbl = {
			{
				frame = 1,
				id = 60320001,
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill2_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "60300_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 3,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 3,
		animation = "skill2_run",
		exe_tbl = {
			{
				id = 60321001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill3 = {
	movingani = "skill3_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "60300_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 3,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 21,
		animation = "skill3_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 60322001
			}
		}
	}
}

return var_0_0
