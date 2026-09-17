local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29020_attack",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "attack"
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
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29020_skill",
					0.6
				}
			},
			{
				id = 29020010,
				frame = 35,
				effect = {
					{
						ani = "skill",
						name = "29020_effect",
						offsetZ = 1,
						offsetY = 1,
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
	usexp = {
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29020_xp",
					0.6
				}
			},
			{
				id = 29030010,
				frame = 70,
				effect = {
					{
						ani = "skill",
						name = "29020_effect",
						offsetZ = 1,
						offsetY = 1,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "29020_bg",
	locktarget = {
		locktargetpool = "self",
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
			texture = "role/29020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
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
				scale = 0.8,
				totalframe = 50,
				startframe = 40
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
	filename = "29020_effect",
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
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				id = 29010010,
				frame = 4
			}
		}
	}
}

return var_0_0
