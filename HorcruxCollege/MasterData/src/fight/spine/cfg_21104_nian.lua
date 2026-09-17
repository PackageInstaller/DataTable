local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
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
					"21100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "11190_21100_effect",
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
					"21100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "11190_21100_effect",
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
					"21100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "11190_21100_effect",
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
					"21100_skill",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "11190_21100_effect",
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
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21100_xp"
				}
			},
			{
				frame = 33,
				id = 21134001,
				effect = {
					{
						ani = "xp",
						name = "11190_21100_effect",
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
	},
	usexp1 = {
		totalframe = 61,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21100_xp",
					0.8
				}
			},
			{
				frame = 33,
				id = 21134101,
				effect = {
					{
						ani = "xp",
						name = "11190_21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"21100_heal"
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 43,
	bgfile = "2020chunjie_bg",
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/21104.png",
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
	lockframe = {},
	camera = {
		zoom = {
			{
				startframe = 8,
				scale = 1.05,
				outtime = 0.1,
				totalframe = 21,
				intime = 0.1
			}
		},
		move = {}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "11190_21100_effect",
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
