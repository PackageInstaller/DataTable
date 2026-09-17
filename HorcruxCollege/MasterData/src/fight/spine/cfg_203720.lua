local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				frame = 15,
				id = 203710011
			}
		}
	},
	attack2 = {
		totalframe = 35,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				frame = 22,
				id = 203710010
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				frame = 10,
				id = 203720010
			},
			{
				frame = 19,
				id = 203720010
			},
			{
				frame = 30,
				id = 203720010
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
		totalframe = 66,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"241_xp",
					0.6
				}
			},
			{
				frame = 45,
				id = 203730010
			},
			{
				frame = 46,
				id = 203730011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "203720_bg",
	totalframe = 66,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/203720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 66,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 66,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
