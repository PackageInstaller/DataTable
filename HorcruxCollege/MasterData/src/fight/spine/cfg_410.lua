local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 15,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"410100-attack",
					0.6
				}
			},
			{
				frame = 9,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 15,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"410100-attack",
					0.6
				}
			},
			{
				frame = 9,
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
		totalframe = 20,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"410200-skill1",
					0.6
				}
			},
			{
				frame = 11,
				bullet = "attack"
			},
			{
				frame = 11,
				bullet = "attack1"
			}
		}
	},
	useskill2 = {
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"410210-skill2",
					0.6
				}
			},
			{
				frame = 18,
				id = 41021001,
				effect = {
					{
						ani = "attack",
						name = "41000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill3 = {
		totalframe = 30,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"410220-skill3",
					0.6
				}
			},
			{
				frame = 17,
				bullet = "skill3",
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 75,
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
			texture = "role/41000.png",
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
				totalframe = 40,
				startframe = 30
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 40,
				startframe = 30,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 76,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"410300-xp",
				0.6
			}
		},
		{
			frame = 33,
			id = 41030001,
			effect = {
				{
					ani = "attack",
					name = "41000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 40,
			id = 41030001,
			effect = {
				{
					ani = "attack",
					name = "41000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 47,
			id = 41030001,
			effect = {
				{
					ani = "attack",
					name = "41000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 54,
			id = 41030001,
			effect = {
				{
					ani = "attack",
					name = "41000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 61,
			id = 41030001,
			effect = {
				{
					ani = "attack",
					name = "41000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			frame = 68,
			id = 41030002,
			effect = {
				{
					ani = "attack",
					name = "41000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "41000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 5,
		animation = "attack",
		exe_tbl = {
			{
				id = 41010001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.attack1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "41000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.4,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.4,
		object = "target"
	},
	attack = {
		totalframe = 5,
		animation = "attack",
		exe_tbl = {
			{
				id = 41010001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill3 = {
	movingani = "skill1_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "41000_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.35,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "skill1_attack",
		exe_tbl = {
			{
				id = 41030001,
				frame = 1
			}
		}
	}
}

return var_0_0
