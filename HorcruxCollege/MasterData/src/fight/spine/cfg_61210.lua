local var_0_0 = {
	xpeffect = {},
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
	useskill3 = {
		totalframe = 35,
		animation = "xp2",
		action_on_complete = {
			{
				method = "remove_invincible"
			},
			{
				method = "complete"
			}
		},
		exe_tbl = {
			{
				frame = 30,
				id = 61250101,
				sound = "20120_skill",
				shake = {
					x = 0,
					y = 8
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
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 65,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 65,
	xpeffect = "xp_effect",
	animation = "xp2",
	exe_tbl = {
		{
			frame = 45,
			id = 61250102,
			sound = "20120_skill",
			shake = {
				x = 0,
				y = 8
			}
		}
	}
}

return var_0_0
