local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 15,
		animation = "attack1",
		exe_tbl = {
			{
				id = 90110001,
				frame = 8,
				effect = {
					{
						ani = "attack",
						name = "90100_effect",
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
				id = 90110001,
				frame = 8,
				effect = {
					{
						ani = "attack",
						name = "90100_effect",
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
				id = 90110001,
				frame = 8,
				effect = {
					{
						ani = "attack",
						name = "90100_effect",
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
				param = "useskill2_1"
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
				id = 90120001,
				frame = 11,
				effect = {
					{
						ani = "attack",
						name = "90100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2_1 = {
		totalframe = 10,
		nextani = true,
		animation = "skill2_1",
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill2_2"
			}
		}
	},
	useskill2_1 = {
		totalframe = 20,
		nextani = true,
		animation = "skill2_2",
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 5,
					posx = 50
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill2_3"
			}
		},
		exe_tbl = {
			{
				id = 90121001,
				frame = 6,
				effect = {
					{
						ani = "attack",
						name = "90100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 90121001,
				frame = 12,
				effect = {
					{
						ani = "attack",
						name = "90100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 90121001,
				frame = 18,
				effect = {
					{
						ani = "attack",
						name = "90100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2_3 = {
		totalframe = 10,
		animation = "skill2_3"
	},
	useskill3 = {
		totalframe = 25,
		animation = "skill3",
		exe_tbl = {
			{
				id = 90122001,
				frame = 13,
				effect = {
					{
						ani = "attack",
						name = "90100_effect",
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
	totalframe = 80,
	initpos = 350,
	bgfile = "44000_bg",
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
			texture = "role/90100.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 40,
			timescale = 0.1
		},
		{
			totalframe = 3,
			startframe = 56,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 55,
				startframe = 30
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 55,
				startframe = 30,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 81,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 38,
			bullet = "xp"
		},
		{
			frame = 54,
			bullet = "xp"
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "90100_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "xp_attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20200_xp1",
					1.2
				}
			},
			{
				id = 90130001,
				frame = 5,
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"20200_xp1",
					1.2
				}
			}
		}
	}
}

return var_0_0
