local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				id = 42210001,
				effect = {
					{
						ani = "attack",
						name = "42201_effect",
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
		totalframe = 33,
		animation = "skill1",
		exe_tbl = {
			{
				id = 42221001,
				frame = 19,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "skill_attack",
						name = "42201_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 35,
		animation = "skill2",
		exe_tbl = {
			{
				id = 42221001,
				frame = 19,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "skill_attack",
						name = "42201_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
	bgfile = "44000_bg",
	locktarget = {
		locktarget = "true"
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
			texture = "role/42201.png",
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
				scale = 0.8,
				totalframe = 42,
				startframe = 36
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 42,
				startframe = 36,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	xpeffect = "xp_effect",
	totalframe = 96,
	animation = "xp",
	action_on_start = {
		{
			startframe = 42,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 1,
						posx = 100
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 1,
			sound = "20600_skill"
		},
		{
			id = 42230001,
			frame = 43,
			sound = "20200_attack",
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			id = 42230001,
			frame = 46,
			sound = "20200_attack",
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			id = 42230001,
			frame = 55,
			sound = "20200_attack",
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			id = 42230001,
			frame = 59,
			sound = "20200_attack",
			shake = {
				x = 6,
				y = 6
			}
		},
		{
			id = 42230002,
			frame = 70,
			sound = "20800_attack",
			shake = {
				x = 6,
				y = 6
			}
		}
	}
}

return var_0_0
