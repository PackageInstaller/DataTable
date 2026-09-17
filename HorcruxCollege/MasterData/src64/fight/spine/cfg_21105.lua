local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 9,
				bullet = "attack",
				sound = {
					"20400_attack",
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
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 12,
				id = 21120001,
				sound = {
					"zhiliao",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	useskill1_1 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 12,
				id = 21120101,
				sound = {
					"zhiliao",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	useskill1_2 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 12,
				id = 21120201,
				sound = {
					"zhiliao",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1_3 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 12,
				id = 21120301,
				sound = {
					"zhiliao",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 61,
		xpeffect = "test",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 33,
				id = 21135001,
				effect = {
					{
						ani = "xp",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"zhiliao",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 31,
	bgfile = "21100_bg",
	locktarget = {
		locktargetpool = "teammate"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/21105.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21104_xp",
				1
			}
		}
	},
	lockframe = {
		{
			time = 0.1,
			totalframe = 3,
			startframe = 27,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				startframe = 8,
				scale = 1.2,
				outtime = 0.2,
				totalframe = 21,
				intime = 0.1
			}
		},
		move = {
			{
				distanceY = 100,
				totalframe = 21,
				startframe = 8,
				time = 0.1
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
	filename = "21100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 1.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0.3,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 21110001,
				frame = 1
			}
		}
	}
}

return var_0_0
