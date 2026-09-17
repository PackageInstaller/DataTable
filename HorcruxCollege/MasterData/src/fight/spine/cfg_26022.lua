local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 32,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"260_atk",
					0.6
				}
			},
			{
				id = 26010001,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "26020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	["attack-fly"] = {
		totalframe = 32,
		animation = "attack_fly",
		exe_tbl = {
			{
				frame = 15,
				id = 26010001,
				sound = {
					"260_skill2",
					0.6
				},
				effect = {
					{
						ani = "attack-fly",
						name = "26020_effect",
						offsetZ = 1,
						offsetY = 0,
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
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
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
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
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
	skill1_fly = {
		{
			{
				method = "useSkill",
				param = "useskill1_fly"
			}
		}
	},
	skill1_1_fly = {
		{
			{
				method = "useSkill",
				param = "useskill1_1_fly"
			}
		}
	},
	skill1_2_fly = {
		{
			{
				method = "useSkill",
				param = "useskill1_2_fly"
			}
		}
	},
	skill1_3_fly = {
		{
			{
				method = "useSkill",
				param = "useskill1_3_fly"
			}
		}
	},
	useskill1 = {
		totalframe = 10,
		animation = "takeoff",
		exe_tbl = {
			{
				frame = 8,
				id = 26020001,
				sound = {
					"260_skill1",
					0.6
				},
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	},
	useskill1_1 = {
		totalframe = 10,
		animation = "takeoff",
		exe_tbl = {
			{
				frame = 8,
				id = 26020101,
				sound = {
					"260_skill1",
					0.6
				},
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 10,
		animation = "takeoff",
		exe_tbl = {
			{
				id = 26020201,
				frame = 8,
				sound = {
					"260_skill1",
					0.6
				},
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	},
	useskill1_3 = {
		totalframe = 10,
		animation = "takeoff",
		exe_tbl = {
			{
				id = 26020301,
				frame = 8,
				sound = {
					"260_skill1",
					0.6
				},
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	},
	useskill1_fly = {
		totalframe = 29,
		animation = "skill-fly",
		exe_tbl = {
			{
				id = 26020001,
				frame = 19,
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	},
	useskill1_1_fly = {
		totalframe = 29,
		animation = "skill-fly",
		exe_tbl = {
			{
				id = 26020101,
				frame = 19,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "26020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_2_fly = {
		totalframe = 29,
		animation = "skill-fly",
		exe_tbl = {
			{
				id = 26020201,
				frame = 19,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "26020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill1_3_fly = {
		totalframe = 29,
		animation = "skill-fly",
		exe_tbl = {
			{
				id = 26020301,
				frame = 19,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "attack",
						name = "26020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 135,
		animation = "xp",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"260_xp",
					0.6
				}
			},
			{
				frame = 10,
				id = 26020001
			},
			{
				id = 26030001,
				behitted = "hitdown",
				frame = 105,
				shake = {
					x = 10,
					y = 0
				},
				effect = {
					{
						ani = "attack",
						name = "26020_effect",
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
	bgfile = "10650_26020_bg",
	totalframe = 135,
	bgfileflipX = true,
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "xp"
		}
	},
	show = {
		{
			action = "hide",
			startframe = 1,
			target = "self"
		},
		{
			action = "hide",
			startframe = 1,
			target = "target"
		},
		{
			action = "show",
			startframe = 101,
			target = "target"
		},
		{
			action = "hide",
			startframe = 108,
			target = "target"
		}
	},
	inserteffect = {
		{
			texture = "role/26020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26020_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distanceY = 500,
				totalframe = 40,
				startframe = 20,
				time = 0.5
			},
			{
				distanceY = -500,
				time = 0.1,
				distance = 200,
				totalframe = 25,
				startframe = 98
			}
		}
	}
}

return var_0_0
