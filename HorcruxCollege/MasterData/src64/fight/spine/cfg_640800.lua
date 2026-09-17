local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				id = 64080021
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
		totalframe = 50,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 14,
				id = 64080031
			},
			{
				frame = 24,
				id = 64080031
			},
			{
				frame = 37,
				id = 64080031
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
	useskill2 = {
		totalframe = 49,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 25,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 400,
							frame = 5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 20,
				id = 64080041
			},
			{
				frame = 35,
				id = 64080042
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
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 10,
				id = 64080052
			},
			{
				frame = 25,
				bullet = "skill"
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "run_skill",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "640800_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 5,
		animation = "skill",
		exe_tbl = {
			{
				frame = 3,
				id = 64080051
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 87,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "100481_xp"
		},
		{
			frame = 35,
			id = 64080062
		},
		{
			id = 64080061,
			behitted = "hitdown",
			frame = 73
		}
	}
}

return var_0_0
