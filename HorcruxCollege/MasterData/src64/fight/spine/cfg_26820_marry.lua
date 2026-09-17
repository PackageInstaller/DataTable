local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"20400_attack",
					0.6
				}
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
	filename = "16810_26820_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26820_skill",
					0.6
				}
			},
			{
				id = 26810010,
				frame = 7
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.skill1 = {
	{
		{
			method = "useSkill",
			param = "useskill1"
		}
	}
}
var_0_0.useskill1 = {
	totalframe = 30,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			id = 26820010,
			frame = 20,
			effect = {
				{
					ani = "skill",
					name = "16810_26820_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 90,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26820_xp",
				0.6
			}
		},
		{
			id = 26830010,
			behitted = "hitdown",
			frame = 54
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "marry_bg",
	locktarget = {
		mindistance = 350,
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
			texture = "role/26820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26820_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 37,
			timescale = 0.4
		}
	}
}

return var_0_0
