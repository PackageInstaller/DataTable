local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10086121,
				frame = 16
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
				id = 10086131,
				behitted = "hitdown",
				frame = 22
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
				id = 10086141,
				frame = 20,
				forceY = {
					{
						speed = 600
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
	usexp = {
		totalframe = 67,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 10086171,
				behitted = "hitdown",
				frame = 20,
				effect = {
					{
						ani = "xp",
						name = "100861_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10086171,
				behitted = "hitdown",
				frame = 30,
				effect = {
					{
						ani = "xp",
						name = "100861_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10086171,
				behitted = "hitdown",
				frame = 42,
				effect = {
					{
						ani = "xp",
						name = "100861_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10086171,
				behitted = "hitdown",
				frame = 53,
				effect = {
					{
						ani = "xp",
						name = "100861_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 67,
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
