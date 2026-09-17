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
					"240_atk",
					0.6
				}
			},
			{
				id = 203210010,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "103210_203220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			},
			{
				frame = 16,
				id = 203210011
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_atk",
					0.6
				}
			},
			{
				id = 203210010,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "103210_203220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			},
			{
				frame = 16,
				id = 203210011
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
		animation = "skill",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"420200-skill1",
					0.6
				}
			},
			{
				frame = 18,
				bullet = "skill1"
			},
			{
				frame = 25,
				id = 203220011
			}
		}
	}
}

var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "103210_203220_effect",
	initpos = {
		offsetY = 0.8,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 203220010,
				frame = 1,
				effect = {
					{
						ani = "attack",
						name = "103210_203220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "self"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "103210_203220_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 203220012,
				frame = 1,
				effect = {
					{
						ani = "attack",
						name = "103210_203220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "self"
					}
				}
			}
		}
	}
}
var_0_0.skill1_dan = {
	{
		{
			method = "useSkill",
			param = "useskill1_dan"
		}
	}
}
var_0_0.useskill1_dan = {
	totalframe = 45,
	animation = "skill",
	exe_tbl = {
		{
			frame = 10,
			sound = {
				"420200-skill1",
				0.6
			}
		},
		{
			frame = 18,
			bullet = "skill1"
		},
		{
			frame = 25,
			bullet = "skill2"
		},
		{
			frame = 25,
			id = 203220011
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "use_xp"
		}
	}
}
var_0_0.use_xp = {
	xpeffect = "test",
	totalframe = 100,
	nextani = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"203220_xp",
				0.6
			}
		},
		{
			id = 203230010,
			frame = 42,
			behitted = "hitdown",
			effect = {
				{
					ani = "attack",
					name = "103210_203220_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 203230010,
			frame = 55,
			behitted = "hitdown",
			effect = {
				{
					ani = "attack",
					name = "103210_203220_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 203230010,
			frame = 68,
			behitted = "hitdown",
			effect = {
				{
					ani = "attack",
					name = "103210_203220_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 203230010,
			frame = 83,
			behitted = "hitdown",
			effect = {
				{
					ani = "attack",
					name = "103210_203220_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 203230011,
			frame = 88,
			effect = {
				{
					ani = "attack",
					name = "103210_203220_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.test = {
	focusoffset = 0,
	bgfilescale = 1.15,
	initpos = 0,
	bgfile = "203220_bg",
	totalframe = 100,
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
			texture = "role/203220.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/203220_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 30,
			timescale = 0.4
		},
		{
			totalframe = 40,
			startframe = 39,
			timescale = 1
		}
	},
	camera = {
		zoom = {
			{
				startframe = 33,
				scale = 0.8,
				anchory = 0,
				outtime = 0.3,
				totalframe = 58,
				intime = 0.1
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 75,
				startframe = 33,
				time = 0.2
			}
		}
	}
}

return var_0_0
