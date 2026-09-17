local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_skill",
					0.6
				}
			},
			{
				id = 26410010,
				frame = 17
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
		skillattackframe = 55,
		totalframe = 50,
		exe_crash_type = "carry",
		animation = "skill",
		exe_crash_bound = 80,
		exe_type = "crash",
		turnbacklimit = true,
		action_on_start = {
			{
				startframe = 35,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 150,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26420_skill1",
					0.6
				}
			},
			{
				id = 26420010,
				frame = 32,
				effect = {
					{
						ani = "skill",
						name = "26420_effect",
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
				param = "usexp1"
			}
		}
	},
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
			}
		}
	},
	usexp1 = {
		totalframe = 95,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26420_xp1",
					0.6
				}
			},
			{
				id = 26430010,
				frame = 60
			},
			{
				id = 26430012,
				frame = 61,
				force = {
					{
						shotdown = false,
						time = 0.5,
						distance = 500,
						object = "target"
					}
				}
			},
			{
				id = 26430011,
				frame = 61
			}
		}
	},
	usexp2 = {
		totalframe = 95,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp2",
		action_on_start = {
			{
				startframe = 28,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 5,
							posx = 50
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26420_xp2",
					0.6
				}
			},
			{
				id = 26430010,
				frame = 60,
				shake = {
					period = 2,
					time = 0.5,
					x = 0,
					y = 20
				},
				forceY = {
					{
						speed = 600
					}
				}
			},
			{
				id = 26430011,
				frame = 60
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
	bgfile = "26420_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/26420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 10,
			startframe = 65,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 60,
				startframe = 60
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 25,
				startframe = 70,
				time = 0.5
			}
		}
	}
}

return var_0_0
