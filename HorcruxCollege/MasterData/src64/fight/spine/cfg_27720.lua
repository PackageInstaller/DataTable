local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_attack",
					0.6
				}
			},
			{
				frame = 18,
				id = 27710010
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_attack",
					0.6
				}
			},
			{
				id = 27710011,
				behitted = "hitdown",
				frame = 10,
				force = {
					{
						time = 0.25,
						shutdown = true,
						distance = 250,
						object = "target"
					}
				}
			}
		}
	},
	attack3 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_attack",
					0.6
				}
			},
			{
				frame = 18,
				id = 27710012
			}
		}
	},
	attack4 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_attack",
					0.6
				}
			},
			{
				id = 27710012,
				behitted = "hitdown",
				frame = 18
			}
		}
	},
	attack5 = {
		totalframe = 30,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_attack",
					0.6
				}
			},
			{
				frame = 18,
				id = 27710012
			}
		}
	},
	attack6 = {
		totalframe = 30,
		animation = "attack4",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_attack",
					0.6
				}
			},
			{
				frame = 18,
				id = 27710012
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
	skill1_xp = {
		{
			{
				method = "useSkill",
				param = "useskill1_xp"
			}
		}
	},
	useskill1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_skill",
					0.6
				}
			},
			{
				id = 27720010,
				behitted = "hitdown",
				frame = 17,
				effect = {
					{
						ani = "attack4_xp",
						name = "27720_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_xp = {
		turnbacklimit = true,
		totalframe = 45,
		animation = "skill",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "grab",
						param = {
							bonename = "role",
							finaloffset = cc.p(100, 0)
						}
					}
				}
			},
			{
				startframe = 45,
				action = {
					{
						method = "releasegrab"
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27720_skill_xp",
					0.7
				}
			},
			{
				frame = 20,
				id = 27720011
			},
			{
				frame = 21,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			},
			{
				id = 27720012,
				frame = 42,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack4_xp",
						name = "27720_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
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
	},
	usexp = {
		totalframe = 120,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 38,
				sound = {
					"100461_xp",
					1
				}
			},
			{
				frame = 20,
				id = 27730010
			},
			{
				id = 27730011,
				behitted = "hitdown",
				frame = 107,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 250,
						object = "target"
					}
				}
			},
			{
				frame = 108,
				id = 27730012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	totalframe = 120,
	bgfile = "27720_bg",
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktargetpool = "oponent"
	},
	inserteffect = {
		{
			texture = "role/27720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/27720_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 10,
			startframe = 65,
			timescale = 0.6
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.95,
				totalframe = 70,
				startframe = 15
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 80,
				startframe = 5,
				time = 2
			}
		},
		moveY = {
			{
				distance = 200,
				totalframe = 80,
				startframe = 5,
				time = 2
			}
		}
	}
}
var_0_0.xp_back = {
	{
		{
			method = "useSkill",
			param = "xpback"
		}
	}
}
var_0_0.xpback = {
	totalframe = 40,
	skill_attack_frame = 20,
	animation = "jieti",
	exe_tbl = {
		{
			frame = 20,
			id = 27730013
		}
	}
}

return var_0_0
