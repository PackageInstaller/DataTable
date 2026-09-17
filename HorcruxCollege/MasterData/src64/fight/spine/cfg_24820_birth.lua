local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 37,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"24820_attack",
					0.6
				}
			},
			{
				id = 24810010,
				frame = 25,
				effect = {
					{
						ani = "attack",
						name = "14850_24820_effect",
						offsetZ = 1,
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
	useskill1 = {
		skillattackframe = 45,
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"24820_skill",
					0.6
				}
			},
			{
				id = 24820010,
				frame = 30,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "14850_24820_effect",
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
		totalframe = 74,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"24820_xp",
					0.6
				}
			},
			{
				id = 24830010,
				frame = 46,
				effect = {
					{
						ani = "xp",
						name = "14850_24820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 24830010,
				frame = 50,
				effect = {
					{
						ani = "xp",
						name = "14850_24820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 51,
				id = 24830011
			},
			{
				id = 24830010,
				frame = 56,
				effect = {
					{
						ani = "xp",
						name = "14850_24820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 24830010,
				frame = 60,
				effect = {
					{
						ani = "xp",
						name = "14850_24820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 61,
				id = 24830011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 74,
	bgfile = "24820_bg",
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktargetpool = "oponent"
	},
	inserteffect = {
		{
			texture = "role/24820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/24820_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 74,
				startframe = 0
			}
		},
		move = {}
	}
}

return var_0_0
