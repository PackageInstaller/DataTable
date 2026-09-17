local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21830-attack",
					0.6
				}
			},
			{
				id = 28010001,
				frame = 4,
				effect = {
					{
						ani = "buff3",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
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
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
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
	useskill1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21830-skill",
					0.6
				}
			},
			{
				id = 28020001,
				frame = 5,
				effect = {
					{
						ani = "buff1",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28020001,
				frame = 25,
				effect = {
					{
						ani = "buff1",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 28020001
			}
		}
	},
	useskill1_1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21830-skill",
					0.6
				}
			},
			{
				id = 28020101,
				frame = 5,
				effect = {
					{
						ani = "buff1",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28020101,
				frame = 25,
				effect = {
					{
						ani = "buff1",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 28020101
			}
		}
	},
	useskill1_2 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21830-skill",
					0.6
				}
			},
			{
				id = 28020201,
				frame = 5,
				effect = {
					{
						ani = "buff1",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28020201,
				frame = 25,
				effect = {
					{
						ani = "buff1",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 28020201
			}
		}
	},
	useskill1_3 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21830-skill",
					0.6
				}
			},
			{
				id = 28020301,
				frame = 5,
				effect = {
					{
						ani = "buff1",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28020301,
				frame = 25,
				effect = {
					{
						ani = "buff1",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 28020301
			}
		}
	},
	usexp = {
		turnbacklimit = false,
		xpeffect = "xp_effect",
		totalframe = 102,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21830-xp",
					0.6
				}
			},
			{
				id = 28030001,
				frame = 35,
				effect = {
					{
						ani = "buff2",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28030001,
				frame = 55,
				effect = {
					{
						ani = "buff2",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28030001,
				frame = 75,
				effect = {
					{
						ani = "buff2",
						name = "21831_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 28030001,
				frame = 95,
				effect = {
					{
						ani = "buff2",
						name = "21831_effect",
						offsetZ = -1,
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
	totalframe = 102,
	bgfile = "21831_bg",
	locktarget = {
		locktargetpool = "self",
		locktarget = true
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
			texture = "role/23830.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 180,
			sound = {
				"role_voice/21830_xp",
				1
			}
		}
	}
}

return var_0_0
