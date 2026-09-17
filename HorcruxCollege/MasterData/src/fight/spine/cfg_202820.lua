local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 0,
				sound = {
					"202820_attack",
					0.6
				},
				effect = {
					{
						ani = "attack",
						name = "202820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 15,
				id = 202810010
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
					"202820_skill",
					0.6
				}
			},
			{
				frame = 32,
				id = 202820010
			},
			{
				id = 202820011,
				frame = 36,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 50,
						object = "target"
					}
				},
				effect = {
					{
						ani = "skill",
						name = "202820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 60,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202820_xp",
					0.6
				}
			},
			{
				frame = 42,
				id = 202830010
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 60,
	bgfile = "202820_bg",
	bgfileflipX = true,
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/202820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/202820_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 40,
			timescale = 0.3
		}
	}
}

return var_0_0
