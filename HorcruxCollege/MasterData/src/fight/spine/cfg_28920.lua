local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				id = 28910010,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "28900_effect",
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
	useskill1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 25,
				id = 28920010,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "28900_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 100,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 100,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				id = 28930010,
				frame = 12,
				effect = {
					{
						ani = "xp",
						name = "28900_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28930010,
				frame = 17,
				effect = {
					{
						ani = "xp",
						name = "28900_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28930010,
				frame = 21,
				effect = {
					{
						ani = "xp",
						name = "28900_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28930010,
				frame = 27,
				effect = {
					{
						ani = "xp",
						name = "28900_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28930010,
				frame = 35,
				effect = {
					{
						ani = "xp",
						name = "28900_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28930010,
				frame = 41,
				effect = {
					{
						ani = "xp",
						name = "28900_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28930011,
				frame = 64,
				behitted = "hitdown",
				effect = {
					{
						ani = "xp",
						name = "28900_effect",
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
	totalframe = 100,
	bgfile = "28900_bg",
	locktarget = {
		maxdistance = 150,
		locktarget = true,
		mindistance = 150
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
			texture = "role/28900.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
