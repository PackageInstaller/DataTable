local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				bullet = "attack",
				sound = {
					"28520_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				bullet = "attack2",
				sound = {
					"28520_attack",
					0.6
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
				frame = 1,
				sound = {
					"28520_skill",
					0.6
				}
			},
			{
				frame = 31,
				bullet = "skill"
			},
			{
				frame = 40,
				id = 285601011
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
				frame = 1,
				sound = {
					"28520_xp",
					0.6
				}
			},
			{
				frame = 60,
				id = 28530010
			},
			{
				frame = 70,
				id = 28530010
			},
			{
				frame = 80,
				id = 28530010
			},
			{
				id = 28530010,
				behitted = "hitdown",
				frame = 90
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "2021chunjie_bg",
	locktarget = {
		mindistance = 400,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "animation"
		}
	},
	inserteffect = {
		{
			texture = "role/28520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/28520_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 200,
				totalframe = 95,
				startframe = 45,
				time = 0.4
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "attack_run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "18590_28520_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				id = 28510010
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "attack_run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "28540_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				id = 28510010
			},
			{
				frame = 6,
				id = 285601010
			}
		}
	}
}
var_0_0.extra.skill = {
	movingani = "skill_run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "18590_28520_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0.3,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 32,
		animation = "skill",
		exe_tbl = {
			{
				id = 28520010,
				behitted = "hitdown",
				frame = 20
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 200,
	movingtype = "lockdirection",
	speed = 400,
	offsetZ = 1,
	filename = "18590_28520_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		totalframe = 1,
		animation = "xp_run",
		exe_tbl = {
			{
				frame = 5
			}
		}
	}
}

return var_0_0
