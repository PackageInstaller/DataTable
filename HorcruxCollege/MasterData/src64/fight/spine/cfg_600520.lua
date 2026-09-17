local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60052021,
				frame = 13,
				effect = {
					{
						ani = "attack",
						name = "600520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
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
		totalframe = 35,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 11,
				bullet = "skill1_qian"
			},
			{
				frame = 21,
				bullet = "skill1_hou"
			}
		}
	}
}

var_0_0.extra.skill1_qian = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "600520_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 60052031
			}
		}
	}
}
var_0_0.extra.skill1_hou = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "600520_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 60052031
			}
		}
	}
}
var_0_0.skill2 = {
	{
		{
			method = "useSkill",
			param = "useskill2"
		}
	}
}
var_0_0.useskill2 = {
	totalframe = 50,
	animation = "xp",
	exe_tbl = {
		{
			id = 60052041,
			frame = 18,
			effect = {
				{
					ani = "skill",
					name = "600520_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			}
		},
		{
			id = 60052041,
			frame = 34,
			effect = {
				{
					ani = "skill",
					name = "600520_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0.5,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 40,
	xpeffect = "xp_effect",
	animation = "skill2",
	exe_tbl = {
		{
			id = 60052061,
			frame = 13,
			effect = {
				{
					ani = "attack",
					name = "100200_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			frame = 13,
			id = 60052062
		},
		{
			id = 60052061,
			frame = 24,
			effect = {
				{
					ani = "attack",
					name = "100200_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 1,
					object = "target"
				}
			}
		},
		{
			frame = 24,
			id = 60052062
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 40,
	bgfile = "22700_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	lockframe = {
		{
			totalframe = 12,
			startframe = 13,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.75,
				totalframe = 78,
				startframe = 15
			}
		},
		move = {
			{
				distance = 250,
				totalframe = 55,
				startframe = 13,
				time = 0.3
			}
		}
	}
}

return var_0_0
