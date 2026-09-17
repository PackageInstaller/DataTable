return {
	attack1 = {
		totalframe = 46,
		animation = "attack1",
		exe_tbl = {
			{
				id = 61210001,
				frame = 27
			}
		}
	},
	attack2 = {
		totalframe = 33,
		animation = "attack2",
		exe_tbl = {
			{
				id = 61210002,
				frame = 22
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
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 38,
		animation = "skill1",
		action_on_start = {
			{
				startframe = 20,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							time = 0.5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 24,
				id = 61220001,
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"20100_skill",
					0.6
				}
			}
		}
	},
	useskill2 = {
		totalframe = 91,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				id = 61230002,
				shake = {
					x = 4,
					y = 0
				}
			},
			{
				frame = 73,
				id = 61230001,
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	},
	useskill3 = {
		totalframe = 48,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				id = 61240001,
				shake = {
					x = 0,
					y = 0
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
	usexp1 = {
		totalframe = 80,
		animation = "xp1",
		exe_tbl = {
			{
				frame = 25,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				}
			},
			{
				frame = 50,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				}
			},
			{
				frame = 75,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "usexp2"
			}
		}
	},
	usexp2 = {
		totalframe = 115,
		animation = "xp2",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 30,
				sound = "20120_skill",
				id = 61250001,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				behitted = "hitdown",
				frame = 45,
				sound = "20120_skill",
				id = 61250001,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				behitted = "hitdown",
				frame = 60,
				sound = "20120_skill",
				id = 61250001,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				behitted = "hitdown",
				frame = 75,
				sound = "20120_skill",
				id = 61250001,
				shake = {
					x = 0,
					y = 8
				}
			},
			{
				behitted = "hitdown",
				frame = 90,
				sound = "20120_skill",
				id = 61250001,
				shake = {
					x = 0,
					y = 8
				}
			}
		}
	}
}
