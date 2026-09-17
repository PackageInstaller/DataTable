local var_0_0 = {
	extra = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 5,
				bullet = "attack1",
				sound = {
					"fire",
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
				frame = 5,
				bullet = "attack2",
				sound = {
					"fire",
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
		totalframe = 25,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21620001,
				frame = 18,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				},
				sound = {
					"horn_fire",
					0.6
				}
			}
		}
	},
	useskill2 = {
		totalframe = 23,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 16,
				bullet = "skill2",
				sound = {
					"fire",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 60,
		turnbacklimit = true,
		animation = "xp",
		lock_screen = {
			texture = "role/21610.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
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
				id = 21630001,
				frame = 36,
				sound = {
					"boom",
					0.6
				}
			},
			{
				id = 21630001,
				frame = 41,
				sound = {
					"boom",
					0.6
				}
			},
			{
				id = 21630001,
				frame = 49,
				sound = {
					"boom",
					0.6
				}
			},
			{
				id = 21630001,
				frame = 52,
				sound = {
					"boom",
					0.6
				}
			}
		}
	},
	usexp1 = {
		totalframe = 60,
		turnbacklimit = true,
		animation = "xp",
		lock_screen = {
			texture = "role/21610.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
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
				id = 21650001,
				frame = 36,
				sound = {
					"boom",
					0.6
				}
			},
			{
				id = 21650001,
				frame = 41,
				sound = {
					"boom",
					0.6
				}
			},
			{
				id = 21650001,
				frame = 49,
				sound = {
					"boom",
					0.6
				}
			},
			{
				id = 21650001,
				frame = 52,
				sound = {
					"boom",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 720,
	offsetZ = 1,
	filename = "21600_effect",
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
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 21610001,
				frame = 2,
				sound = {
					"boom",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 450,
	movingtype = "locktarget",
	speed = 720,
	offsetZ = 1,
	filename = "21600_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 21610001,
				frame = 2,
				sound = {
					"boom",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill2_run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "21600_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.7,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "skill2_attack2",
		exe_tbl = {
			{
				id = 21621001,
				frame = 1,
				sound = {
					"boom",
					0.6
				}
			}
		}
	}
}

return var_0_0
