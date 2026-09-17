local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 28,
		animation = "attack",
		exe_tbl = {
			{
				frame = 13,
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
	useskill1 = {
		totalframe = 33,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 13,
				bullet = "skill1"
			}
		}
	},
	useskill2 = {
		totalframe = 50,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 17,
				id = 41221001,
				effect = {
					{
						ani = "attack",
						name = "41200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 23,
				id = 41221001,
				effect = {
					{
						ani = "attack",
						name = "41200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 29,
				id = 41221001,
				effect = {
					{
						ani = "attack",
						name = "41200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 35,
				id = 41221001,
				effect = {
					{
						ani = "attack",
						name = "41200_effect",
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
	totalframe = 81,
	bgfile = "44000_bg",
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
	inserteffect = {
		{
			texture = "role/41205.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 35,
			timescale = 0.2
		}
	},
	camera = {
		move = {
			{
				pos = "target",
				totalframe = 35,
				startframe = 40,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 82,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "20600_skill"
		},
		{
			id = 41230001,
			frame = 48,
			sound = "20400_attack",
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			id = 41230001,
			frame = 52,
			sound = "20400_attack",
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			id = 41230001,
			frame = 56,
			sound = "20400_attack",
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			id = 41230001,
			frame = 60,
			sound = "20400_attack",
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			id = 41230001,
			frame = 64,
			sound = "20400_attack",
			shake = {
				x = 4,
				y = 4
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "41200_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.37,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 41210001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill1_run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "41200_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.37,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 41220001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
