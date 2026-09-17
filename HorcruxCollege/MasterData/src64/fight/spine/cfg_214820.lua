local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 214810010,
				frame = 17
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
		totalframe = 47,
		turnbacklimit = false,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 10,
				id = 214820010
			},
			{
				id = 214820011,
				behitted = "hitdown",
				frame = 32
			},
			{
				id = 214820011,
				behitted = "hitdown",
				frame = 36
			}
		}
	},
	usexp = {
		totalframe = 100,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_xp",
					0.6
				}
			},
			{
				frame = 31,
				id = 214830010
			},
			{
				frame = 57,
				id = 214830011
			},
			{
				frame = 60,
				id = 214830011
			},
			{
				frame = 65,
				id = 214830011
			},
			{
				frame = 70,
				id = 214830011
			},
			{
				frame = 75,
				id = 214830011
			},
			{
				frame = 80,
				id = 214830012
			},
			{
				frame = 75,
				id = 214830014
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "214820_bg",
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
			texture = "role/214820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/214820_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
