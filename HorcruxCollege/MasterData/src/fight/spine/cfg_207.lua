return {
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 20710001,
				frame = 9,
				sound = {
					"huiwu_z",
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
				id = 20710001,
				frame = 10,
				sound = {
					"huiwu_z",
					0.6
				}
			}
		}
	},
	attack3 = {
		totalframe = 20,
		animation = "attack3",
		exe_tbl = {
			{
				id = 20710001,
				frame = 7,
				sound = {
					"huiwu_z",
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
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
			}
		}
	},
	xp3 = {
		{
			{
				method = "useSkill",
				param = "usexp3"
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
		totalframe = 40,
		animation = "skill1",
		exe_tbl = {
			{
				id = 20720001,
				frame = 12,
				sound = {
					"huiwu_z",
					0.6
				}
			},
			{
				id = 20720001,
				frame = 19,
				sound = {
					"huiwu_z",
					0.6
				}
			},
			{
				frame = 29,
				id = 20720001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				},
				sound = {
					"huiwu_z",
					0.6
				}
			}
		}
	},
	useskill2 = {
		totalframe = 40,
		animation = "skill2",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 22,
				id = 20721001,
				shake = {
					x = 0,
					y = 6
				},
				sound = {
					"zaxia",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 57,
		animation = "xp",
		lock_screen = {
			texture = "role/20703.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 3,
					posx = 50
				}
			}
		},
		exe_tbl = {
			{
				frame = 38,
				id = 20730001,
				shake = {
					x = 0,
					y = 4
				},
				sound = {
					"zaxia",
					0.6
				}
			}
		}
	},
	usexp1 = {
		totalframe = 57,
		animation = "xp",
		lock_screen = {
			texture = "role/20701.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 3,
					posx = 50
				}
			}
		},
		exe_tbl = {
			{
				frame = 38,
				id = 20731001,
				shake = {
					x = 0,
					y = 4
				},
				sound = {
					"zaxia",
					0.6
				}
			}
		}
	},
	usexp2 = {
		totalframe = 57,
		animation = "xp",
		lock_screen = {
			texture = "role/20703.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 3,
					posx = 50
				}
			}
		},
		exe_tbl = {
			{
				frame = 38,
				id = 20733001,
				shake = {
					x = 0,
					y = 4
				},
				sound = {
					"zaxia",
					0.6
				}
			}
		}
	},
	usexp3 = {
		totalframe = 57,
		animation = "xp",
		lock_screen = {
			texture = "role/20710.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		action_on_start = {
			{
				method = "rush_to_target",
				param = {
					frame = 3,
					posx = 50
				}
			}
		},
		exe_tbl = {
			{
				frame = 38,
				id = 20740001,
				shake = {
					x = 0,
					y = 4
				},
				sound = {
					"zaxia",
					0.6
				}
			}
		}
	}
}
