local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60021021,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "600210_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = "20120-skill"
			},
			{
				id = 60021031,
				frame = 27,
				effect = {
					{
						ani = "attack",
						name = "600210_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill2 = {
		totalframe = 40,
		animation = "skill2",
		exe_tbl = {
			{
				1.2,
				frame = 1,
				sound = "20520-skill"
			},
			{
				id = 60021041,
				behitted = "hitdown",
				frame = 23
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
	usexp = {
		totalframe = 80,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				0.6,
				frame = 10,
				sound = "23720-skill"
			},
			{
				0.8,
				frame = 20,
				sound = "23720-skill"
			},
			{
				0.6,
				frame = 30,
				sound = "23720-skill"
			},
			{
				0.8,
				frame = 40,
				sound = "23720-skill"
			},
			{
				0.8,
				frame = 50,
				sound = "23720-skill"
			},
			{
				frame = 34,
				id = 60021061,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "600210_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 41,
				id = 60021061,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "600210_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 60021061,
				frame = 48,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "600210_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 60021061,
				frame = 54,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "600210_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 80,
	bgfile = "45080_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	}
}

return var_0_0
