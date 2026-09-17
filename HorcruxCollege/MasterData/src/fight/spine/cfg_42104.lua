local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 42110001,
				frame = 15
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
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 11,
				id = 42120001
			}
		}
	},
	useskill2 = {
		totalframe = 27,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 15,
				id = 42121001
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 67,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "all"
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
			texture = "role/42104.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.95,
				totalframe = 22,
				startframe = 35
			}
		}
	}
}
var_0_0.usexp = {
	exe_crash_type = "carry",
	xpeffect = "xp_effect",
	exe_crash_bound = 40,
	exe_type = "crash",
	totalframe = 68,
	animation = "xp",
	action_on_start = {
		{
			startframe = 21,
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
			id = 42130001,
			frame = 16,
			sound = "20120_skill",
			shake = {
				x = 5,
				y = 0
			}
		}
	}
}

return var_0_0
