local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 10,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
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
					"202520_attack",
					0.6
				}
			},
			{
				frame = 14,
				id = 202510010,
				effect = {
					{
						ani = "attack",
						name = "102530_202520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202520_attack",
					0.6
				}
			},
			{
				frame = 14,
				id = 202510010,
				effect = {
					{
						ani = "attack",
						name = "102530_202520_effect",
						offsetZ = 1,
						offsetY = 0.5,
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
	useskill1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202520_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 202520010
			},
			{
				frame = 31,
				id = 202520011
			},
			{
				frame = 32,
				id = 202520011
			},
			{
				frame = 33,
				id = 202520011
			},
			{
				frame = 34,
				id = 202520011
			}
		}
	},
	usexp = {
		totalframe = 97,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202520_xp",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 202530010,
				frame = 72,
				shake = {
					x = 0,
					y = 20
				},
				forceY = {
					{
						speed = 600,
						distance = 500,
						time = 0.1
					}
				}
			},
			{
				frame = 73,
				id = 202530011
			},
			{
				frame = 74,
				id = 202530011
			},
			{
				frame = 75,
				id = 202530011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 97,
	bgfile = "202520_bg",
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
			texture = "role/202520.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/202520_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 70,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.95,
				totalframe = 100,
				startframe = 0
			}
		}
	}
}

return var_0_0
