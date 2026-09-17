local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				id = 20610001,
				frame = 16,
				sound = {
					"20600_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				id = 20610001,
				frame = 16,
				sound = {
					"20600_attack",
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
		totalframe = 29,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 20621001,
				frame = 17
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
		totalframe = 29,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 20621101,
				frame = 17
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
		totalframe = 29,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 20621201,
				frame = 17
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
		totalframe = 29,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 20621301,
				frame = 17
			}
		}
	},
	usexp = {
		totalframe = 86,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_xp"
				}
			},
			{
				frame = 60,
				id = 20650001,
				effect = {
					{
						ani = "buff",
						name = "10650_20620_effect",
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
	totalframe = 85,
	bgfile = "20620_bg",
	nozorder = true,
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
			texture = "role/20620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20630_xp"
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 0
			}
		},
		move = {}
	}
}

return var_0_0
