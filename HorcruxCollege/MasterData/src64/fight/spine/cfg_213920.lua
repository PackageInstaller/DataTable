local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 27,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-attack",
					0.6
				}
			},
			{
				id = 213910010,
				frame = 12
			}
		}
	},
	attack2 = {
		totalframe = 27,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20800_skill",
					0.6
				}
			},
			{
				id = 213910010,
				frame = 12
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
	useskill1 = {
		totalframe = 50,
		turnbacklimit = false,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22500_skill",
					1
				}
			},
			{
				frame = 32,
				id = 213920010
			},
			{
				frame = 33,
				id = 213920011
			},
			{
				frame = 34,
				id = 213920012
			}
		}
	},
	usexp = {
		totalframe = 81,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22220_xp",
					2
				}
			},
			{
				frame = 51,
				id = 213930010
			},
			{
				frame = 52,
				id = 213930011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 81,
	bgfile = "213920_bg",
	locktarget = {
		locktargetpool = "oponent"
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
			texture = "role/213920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213920_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 275,
				time = 0.2,
				distanceY = 0,
				totalframe = 36,
				startframe = 45
			}
		}
	}
}

return var_0_0
