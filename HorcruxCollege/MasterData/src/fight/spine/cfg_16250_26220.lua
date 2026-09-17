local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 24,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1
			},
			{
				frame = 19,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 21,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1
			},
			{
				frame = 16,
				bullet = "attack",
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "16250_26200_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 1000,
					maxcatapult = 1,
					condition = "random"
				}
			}
		},
		exe_tbl = {
			{
				id = 26210001,
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
	totalframe = 48,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26220_skill",
				0.6
			}
		},
		{
			id = 26220001,
			frame = 17,
			effect = {
				{
					ani = "skill",
					name = "16250_26200_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 26220001,
			frame = 40,
			effect = {
				{
					ani = "skill",
					name = "16250_26200_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = false,
	xpeffect = "xp_effect",
	totalframe = 108,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26220_xp",
				0.6
			}
		},
		{
			behitted = "hitdown",
			id = 26230001,
			frame = 78,
			effect = {
				{
					ani = "skill",
					name = "16250_26200_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			forceY = {
				{
					speed = 200,
					distance = 100,
					time = 0.1
				}
			}
		},
		{
			id = 26230001,
			behitted = "hitdown",
			frame = 93,
			forceY = {
				{
					speed = 200,
					distance = 100,
					time = 0.1
				}
			}
		},
		{
			id = 26230001,
			behitted = "hitdown",
			frame = 100,
			forceY = {
				{
					speed = 200,
					distance = 100,
					time = 0.1
				}
			}
		},
		{
			behitted = "hitdown",
			id = 26230001,
			frame = 105,
			forceY = {
				{
					speed = 200,
					distance = 100,
					time = 0.1
				}
			},
			shake = {
				period = 2,
				time = 0.2,
				x = 0,
				y = 20
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	totalframe = 108,
	bgfile = "26200_BG",
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
	},
	inserteffect = {
		{
			texture = "role/23820.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26220_xp",
				1
			}
		}
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 1.2,
				outtime = 0.3,
				totalframe = 30,
				intime = 0.1
			},
			{
				startframe = 31,
				scale = 1,
				outtime = 0.3,
				totalframe = 30,
				intime = 0.1
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 59,
				startframe = 0,
				time = 0.1
			},
			{
				pos = "target",
				totalframe = 24,
				startframe = 59,
				time = 0.2
			}
		}
	}
}

return var_0_0
