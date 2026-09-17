local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				id = 205110010,
				frame = 18,
				effect = {
					{
						ani = "attack",
						name = "205120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 19,
				id = 205110011
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
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 22,
				id = 205120012
			},
			{
				frame = 22,
				id = 205120011
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
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 20,
				id = 205130010
			},
			{
				frame = 75,
				id = 205130014
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.75,
	bgfile = "205120_bg",
	totalframe = 90,
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
			texture = "role/205120.png",
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
			totalframe = 110,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 110,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
