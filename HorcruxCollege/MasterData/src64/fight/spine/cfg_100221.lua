local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10022161,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "100221_effect",
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
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	useskill1 = {
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 39,
		animation = "skill",
		action_on_start = {
			{
				startframe = 13,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10022171,
				frame = 13,
				effect = {
					{
						ani = "skill",
						name = "100221_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 60,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 10022191,
				frame = 23
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 60,
	bgfile = "77102_bg",
	locktarget = {
		locktargetpool = "self",
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 40,
				startframe = 0
			},
			{
				scale = 1,
				totalframe = 42,
				startframe = 45
			}
		},
		move = {
			{
				distance = -100,
				totalframe = 50,
				startframe = 25,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100221_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10022161,
				frame = 10
			}
		}
	}
}

return var_0_0
