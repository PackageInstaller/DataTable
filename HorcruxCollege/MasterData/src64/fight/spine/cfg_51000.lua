local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23220-attack",
					0.6
				}
			},
			{
				id = 51010001,
				frame = 13
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
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23720-skill",
					0.6
				}
			},
			{
				id = 51020001,
				behitted = "hitdown",
				frame = 27
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
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 107,
		animation = "xp",
		exe_tbl = {
			{
				frame = 4
			},
			{
				id = 51030001,
				behitted = "hitdown",
				frame = 50,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				id = 51030001,
				behitted = "hitdown",
				frame = 54,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				id = 51030001,
				behitted = "hitdown",
				frame = 58,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				id = 51030001,
				behitted = "hitdown",
				frame = 62,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				id = 51030001,
				behitted = "hitdown",
				frame = 66,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				id = 51030001,
				behitted = "hitdown",
				frame = 70,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				id = 51030001,
				behitted = "hitdown",
				frame = 73,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				id = 51030001,
				behitted = "hitdown",
				frame = 76,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				id = 51030002,
				behitted = "hitdown",
				frame = 96,
				sound = {
					"20100_attack",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 107,
	bgfile = "51000_bg",
	bgfileflipX = true,
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "xp"
		}
	},
	inserteffect = {
		{
			texture = "role/51000.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	}
}

return var_0_0
