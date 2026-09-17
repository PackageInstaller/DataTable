local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				id = 37910001,
				frame = 13,
				sound = {
					"5200_ci",
					1
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
	useskill1 = {
		totalframe = 60,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 38,
				sound = {
					"5200_ci2",
					1
				}
			},
			{
				id = 37920001,
				frame = 57
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
		totalframe = 20,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 10,
				bullet = "skill2"
			}
		}
	}
}

var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 400,
	offsetZ = 1,
	filename = "37999_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 2,
		animation = "skill3",
		exe_tbl = {
			{
				id = 37921001,
				frame = 1
			}
		}
	}
}
var_0_0.skill3 = {
	{
		{
			method = "useSkill",
			param = "useskill3"
		}
	}
}
var_0_0.useskill3 = {
	totalframe = 60,
	animation = "skill3",
	exe_tbl = {
		{
			frame = 15,
			force = {
				{
					time = 0.2,
					shutdown = false,
					distance = 300,
					object = "self"
				}
			}
		},
		{
			frame = 37,
			sound = {
				"5200_ci2",
				1
			}
		},
		{
			id = 37930001,
			frame = 40
		}
	}
}

return var_0_0
