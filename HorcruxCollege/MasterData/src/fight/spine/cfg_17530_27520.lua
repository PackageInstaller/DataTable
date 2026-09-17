local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
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
	speed = 600,
	offsetZ = 1,
	filename = "17530_27520_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.6,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 27510010,
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
	skillattackframe = 45,
	totalframe = 35,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27520_skill",
				0.6
			}
		},
		{
			frame = 20,
			id = 27520010
		}
	}
}
var_0_0.usexp = {
	totalframe = 110,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	nextani = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27520_xp",
				0.6
			}
		},
		{
			frame = 106
		},
		{
			id = 27530010,
			frame = 110,
			effect = {
				{
					ani = "smoke",
					name = "27520_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_smoke"
		}
	}
}
var_0_0.xp_smoke = {
	totalframe = 60,
	animation = "none",
	action_on_start = {
		{
			startframe = 4,
			action = {
				{
					method = "change_to_invincible"
				}
			}
		}
	},
	action_on_complete = {
		{
			method = "remove_invincible"
		},
		{
			method = "complete"
		}
	},
	exe_tbl = {
		{
			frame = 0,
			effect = {
				{
					ani = "smoke",
					name = "27520_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "self"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 110,
	bgfile = "17530_27520_BG",
	locktarget = {
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
			texture = "role/27520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/27520_xp",
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
