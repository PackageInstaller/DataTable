local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				sound = {
					"201020_attack",
					0.6
				}
			},
			{
				frame = 10,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "214320_effect",
	initpos = {
		offsetY = 3.6,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 214310010,
				frame = 1
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
	totalframe = 50,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"201020_skill",
				0.6
			}
		},
		{
			frame = 30,
			id = 214320010
		},
		{
			frame = 31,
			id = 214320010
		},
		{
			frame = 33,
			id = 214320010
		},
		{
			frame = 34,
			id = 214320010
		},
		{
			frame = 38,
			id = 214320010
		},
		{
			frame = 39,
			id = 214320011
		},
		{
			frame = 40,
			id = 214320012
		}
	}
}
var_0_0.usexp = {
	totalframe = 95,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"201020_xp",
				0.6
			}
		},
		{
			id = 214330010,
			behitted = "hitdown",
			frame = 61,
			shake = {
				x = 0,
				y = 20
			}
		},
		{
			frame = 82,
			id = 214330011
		},
		{
			frame = 83,
			id = 214330012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 95,
	bgfile = "214320_bg",
	bgfileflipX = true,
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
			texture = "role/214320.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/214320_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 250,
				time = 0.5,
				distanceY = 0,
				totalframe = 100,
				startframe = 30
			}
		}
	}
}

return var_0_0
