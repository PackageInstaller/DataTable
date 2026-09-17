local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 34,
		animation = "attack",
		exe_tbl = {
			{
				id = 10035161,
				frame = 18
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
		totalframe = 50,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 20,
				sound = {
					"21000_attack",
					1.2
				}
			},
			{
				frame = 25,
				id = 10035171,
				effect = {
					{
						ani = "skill1",
						name = "100351_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 30,
				id = 10035171,
				effect = {
					{
						ani = "skill1",
						name = "100351_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 10035171,
				frame = 35,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill1",
						name = "100351_effect",
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
		totalframe = 40,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 15,
				id = 10035181,
				effect = {
					{
						ani = "xp",
						name = "100351_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 22,
				id = 10035181,
				effect = {
					{
						ani = "xp",
						name = "100351_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 27,
				id = 10035181,
				effect = {
					{
						ani = "xp",
						name = "100351_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
	useskill3 = {
		totalframe = 65,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 25,
				id = 10035201,
				effect = {
					{
						ani = "attack",
						name = "100351_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"shilian",
					0.8
				}
			},
			{
				frame = 35,
				id = 10035201,
				effect = {
					{
						ani = "attack",
						name = "100351_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 10035201,
				effect = {
					{
						ani = "attack",
						name = "100351_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 55,
				id = 10035201,
				effect = {
					{
						ani = "attack",
						name = "100351_effect",
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
				param = "qianyao"
			}
		}
	},
	qianyao = {
		totalframe = 18,
		nextani = true,
		animation = "die",
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
			startframe = 22
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
	usexp = {
		xpeffect = "xp_effect",
		totalframe = 54,
		animation = "xp",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"254_skill",
					1.2
				}
			},
			{
				frame = 30,
				behitted = "hitdown",
				bullet = "xp",
				sound = {
					"20500_xp2",
					1.2
				},
				force = {
					{
						time = 0.4,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "lockdirection",
	speed = 600,
	offsetZ = 1,
	filename = "100351_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.6,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 25,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10035191,
				frame = 5,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill2",
						name = "100351_effect",
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
	totalframe = 55,
	bgfile = "77100_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	lockframe = {
		{
			totalframe = 4,
			startframe = 20,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 40,
				startframe = 16
			}
		},
		move = {
			{
				distance = 150,
				time = 0.3,
				distanceY = 0,
				totalframe = 40,
				startframe = 16
			}
		}
	}
}

return var_0_0
