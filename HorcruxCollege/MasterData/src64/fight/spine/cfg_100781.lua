return {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = ">=",
				method = "random",
				param = {
					num = 5,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10078120,
				frame = 10
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 10078120,
				frame = 10
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
		animation = "skill",
		exe_tbl = {
			{
				id = 10078130,
				frame = 35,
				behitted = "hitdown",
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = 50,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 600
					}
				},
				effect = {
					{
						ani = "skill",
						name = "100781_effect",
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
		turnbacklimit = true,
		totalframe = 50,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							time = 0.7
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 15,
				behitted = "hitdown",
				id = 10078140
			},
			{
				frame = 25,
				behitted = "hitdown",
				id = 10078140
			}
		}
	},
	useskill3 = {
		totalframe = 50,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 40,
				behitted = "hitdown",
				id = 10078150,
				forceY = {
					{
						speed = 600
					}
				}
			}
		}
	}
}
