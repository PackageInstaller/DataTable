local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 50,
		animation = "attack",
		exe_tbl = {
			{
				id = 61310101,
				frame = 20
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill1 = {
		totalframe = 77,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 28,
				bullet = "skill1"
			}
		}
	},
	useskill2 = {
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 15,
				id = 61330101,
				bullet = "skill2"
			}
		}
	},
	useskill3 = {
		totalframe = 47,
		animation = "skill3",
		exe_tbl = {
			{
				id = 61340101,
				frame = 30,
				effect = {
					{
						ani = "skill3-buff2",
						name = "61300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "self"
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
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 50,
		animation = "XP",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 61350101,
				frame = 33,
				shake = {
					x = 0,
					y = 8
				},
				forceY = {
					{
						speed = 1400
					}
				},
				effect = {
					{
						ani = "XP_miaozhun",
						name = "61300_effect",
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

var_0_0.extra.skill1 = {
	movingani = "skill",
	maxdistance = 1000,
	movingtype = "locktime",
	speed = 1500,
	offsetZ = 1,
	filename = "61300_effect",
	size = {
		width = 80,
		height = 100
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.6,
		time = 0.1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				id = 61320101,
				behitted = "hitdown",
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "61300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 61320101,
				behitted = "hitdown",
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "61300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 61320101,
				behitted = "hitdown",
				frame = 35,
				effect = {
					{
						ani = "attack",
						name = "61300_effect",
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
var_0_0.extra.skill2 = {
	movingani = "skill2",
	maxdistance = 1000,
	movingtype = "locktime",
	speed = 1500,
	offsetZ = 1,
	filename = "61300_effect",
	size = {
		width = 80,
		height = 100
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.6,
		time = 0.1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "skill2-attack",
		exe_tbl = {
			{
				frame = 0,
				id = 61330101,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				},
				shake = {
					x = 10,
					y = 0
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
	bgfile = "44000_bg",
	locktarget = {
		locktarget = true
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
