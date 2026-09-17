local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				id = 10014161,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
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
	useskill1 = {
		totalframe = 40,
		nextani = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 10014171,
				frame = 18,
				effect = {
					{
						ani = "skill1",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "walk"
			}
		}
	},
	walk = {
		turnbacklimit = true,
		totalframe = 30,
		animation = "walk",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 1
						}
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 45,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 25,
				id = 10014181,
				effect = {
					{
						ani = "attack",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "walk"
			}
		}
	},
	useskill3 = {
		totalframe = 55,
		animation = "skill3",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 10014191,
				frame = 30,
				effect = {
					{
						ani = "skill1",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"28720_attack2",
					1.2
				},
				force = {
					{
						time = 0.5,
						shutdown = true,
						distance = 650,
						object = "target"
					}
				},
				forceY = {
					speed = 500
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "walk"
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
		totalframe = 20,
		nextani = true,
		animation = "die",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -10,
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
		totalframe = 100,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 10014141,
				behitted = "hitdown",
				frame = 27,
				effect = {
					{
						ani = "xp",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				},
				sound = {
					"260_skill1",
					1.2
				}
			},
			{
				id = 10014141,
				behitted = "hitdown",
				frame = 35,
				effect = {
					{
						ani = "xp",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				},
				sound = {
					"260_skill1",
					1.2
				}
			},
			{
				id = 10014141,
				behitted = "hitdown",
				frame = 47,
				effect = {
					{
						ani = "xp",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				},
				sound = {
					"260_skill1",
					1.2
				}
			},
			{
				id = 10014141,
				behitted = "hitdown",
				frame = 55,
				effect = {
					{
						ani = "xp",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				},
				sound = {
					"260_skill1",
					1.2
				}
			},
			{
				id = 10014141,
				behitted = "hitdown",
				frame = 67,
				effect = {
					{
						ani = "xp",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				},
				sound = {
					"260_skill1",
					1.2
				}
			},
			{
				id = 10014141,
				behitted = "hitdown",
				frame = 75,
				effect = {
					{
						ani = "xp",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				},
				sound = {
					"260_skill1",
					1.2
				}
			},
			{
				frame = 85,
				id = 10014141,
				behitted = "hitdown",
				effect = {
					{
						ani = "xp",
						name = "100141_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = 550,
						object = "target"
					}
				},
				forceY = {
					speed = 200
				},
				sound = {
					"260_skill1",
					1.2
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "70100_bg",
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
	lockframe = {
		{
			totalframe = 4,
			startframe = 6,
			timescale = 0.1
		},
		{
			totalframe = 4,
			startframe = 84,
			timescale = 0.15
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
				distance = -80,
				totalframe = 25,
				startframe = 30,
				time = 0.1
			}
		}
	}
}

return var_0_0
