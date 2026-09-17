local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				id = 77110001,
				frame = 14,
				sound = {
					"20600_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 77110001,
				frame = 13,
				effect = {
					{
						ani = "attack",
						name = "77100_effect",
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
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1
			},
			{
				id = 77120001,
				frame = 15,
				effect = {
					{
						ani = "skill1",
						name = "77100_effect",
						offsetZ = 1,
						offsetY = 0,
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
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				id = 77121001,
				frame = 27,
				effect = {
					{
						ani = "skill2",
						name = "77100_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
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
	useskill3 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20600_skill",
					0.6
				}
			},
			{
				id = 77122001,
				frame = 17
			}
		}
	},
	usexp = {
		totalframe = 75,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				id = 77130001,
				behitted = "hitdown",
				frame = 26
			},
			{
				frame = 28,
				bullet = "xp"
			},
			{
				frame = 40,
				bullet = "xp2"
			},
			{
				behitted = "hitdown",
				id = 77130001,
				frame = 43,
				forceY = {
					{
						speed = 600,
						distance = 500,
						time = 0.1
					}
				}
			},
			{
				behitted = "hitdown",
				id = 77130001,
				frame = 48,
				forceY = {
					{
						speed = 600,
						distance = 500,
						time = 0.1
					}
				}
			},
			{
				frame = 60,
				id = 77130001,
				effect = {
					{
						ani = "xp1",
						name = "77100_effect",
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

var_0_0.xpeffect.xp_effect = {
	totalframe = 75,
	bgfile = "77100_bg",
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 43,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 47,
				startframe = 28
			}
		},
		move = {
			{
				distance = 300,
				time = 0.6,
				distanceY = 0,
				totalframe = 47,
				startframe = 28
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 300,
	movingtype = "lockdirection",
	speed = 750,
	offsetZ = 1,
	filename = "77100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		totalframe = 35,
		animation = "xp",
		exe_tbl = {
			{
				id = 77130001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21020_effect",
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
var_0_0.extra.xp2 = {
	movingani = "xp",
	maxdistance = 10,
	movingtype = "lockdirection",
	speed = 1000,
	offsetZ = 1,
	filename = "77100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "once",
		direction = 1
	},
	attack = {
		totalframe = 40,
		animation = "xp",
		exe_tbl = {
			{
				id = 77130001,
				frame = 5
			}
		}
	}
}

return var_0_0
