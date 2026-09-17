local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				id = 10011161,
				frame = 18
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				id = 10011171,
				frame = 27,
				force = {
					{
						time = 0.3,
						shutdown = true,
						distance = 280,
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
	usexp = {
		totalframe = 85,
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 50,
				effect = {
					{
						ani = "xp",
						name = "100111_effect",
						offsetZ = 1,
						offsetY = 0.4,
						offsetX = 0.2,
						object = "target"
					}
				}
			},
			{
				id = 10011191,
				frame = 56
			},
			{
				id = 10011191,
				frame = 58
			},
			{
				id = 10011191,
				frame = 61
			},
			{
				id = 10011191,
				frame = 63
			},
			{
				id = 10011191,
				frame = 68
			},
			{
				id = 10011191,
				frame = 70
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 75,
	bgfile = "77102_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			totalframe = 5,
			startframe = 5,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 70,
				startframe = 30
			}
		},
		move = {}
	}
}

return var_0_0
