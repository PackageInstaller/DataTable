local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 28,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29120_attack",
					0.6
				}
			},
			{
				id = 29110010,
				frame = 17,
				effect = {
					{
						ani = "attack",
						name = "19110_29120_effect",
						offsetZ = 1,
						offsetY = 0.8,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 28,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1
			},
			{
				id = 29110010,
				frame = 16,
				effect = {
					{
						ani = "attack",
						name = "19110_29120_effect",
						offsetZ = 1,
						offsetY = 0.8,
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
	useskill1 = {
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29120_skill",
					0.6
				}
			},
			{
				id = 29120010,
				frame = 20,
				effect = {
					{
						ani = "skill",
						name = "19110_29120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 30,
				id = 29120011
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
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29120_xp",
					0.6
				}
			},
			{
				id = 29130010,
				frame = 55,
				effect = {
					{
						ani = "xp",
						name = "19110_29120_effect",
						offsetZ = 1,
						offsetY = 1,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 60,
				id = 29120011
			},
			{
				frame = 61,
				id = 29120011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 85,
	bgfile = "29120_bg",
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
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
			texture = "role/29120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	camera = {
		zoom = {
			{
				scale = 1,
				totalframe = 85,
				startframe = 46
			}
		}
	}
}

return var_0_0
