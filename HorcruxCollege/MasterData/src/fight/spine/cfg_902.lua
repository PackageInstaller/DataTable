local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 16,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack"
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
		totalframe = 18,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 10,
				bullet = "skill1"
			}
		}
	},
	useskill2 = {
		totalframe = 18,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 10,
				bullet = "skill2"
			}
		}
	},
	useskill3 = {
		totalframe = 25,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 10,
				effect = {
					{
						ani = "skill3",
						name = "90200_effect",
						offsetZ = 1,
						offsetY = 0.3,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 90222001,
				frame = 18,
				shake = {
					x = 0,
					y = 4
				}
			}
		}
	},
	usexp = {
		totalframe = 51,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 35,
				bullet = "xp"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
	initpos = 350,
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
	},
	inserteffect = {
		{
			texture = "role/90200.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 30,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 25,
				startframe = 20
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 25,
				startframe = 20,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "bullet_run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "90200_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.8,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "bullet_attack",
		exe_tbl = {
			{
				frame = 5,
				id = 90210001
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill1_run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "90200_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill1_attack",
		exe_tbl = {
			{
				id = 90220001,
				frame = 5,
				shake = {
					x = 2,
					y = 0
				}
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill2_run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "90200_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill2_attack",
		exe_tbl = {
			{
				id = 90221001,
				frame = 5,
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "90200_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 90230001,
				frame = 5,
				shake = {
					x = 6,
					y = 6
				},
				sound = {
					"20500_xp1",
					1.2
				}
			}
		}
	}
}

return var_0_0
