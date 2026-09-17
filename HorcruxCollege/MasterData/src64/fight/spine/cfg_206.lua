local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 29,
		animation = "attack",
		exe_tbl = {
			{
				id = 20610001,
				frame = 13,
				effect = {
					{
						ani = "attack",
						name = "20600_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"huiwu",
					0.6
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
			}
		}
	},
	xp3 = {
		{
			{
				method = "useSkill",
				param = "usexp3"
			}
		}
	},
	xp4 = {
		{
			{
				method = "useSkill",
				param = "usexp4"
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
				param = "useskill2_1"
			}
		}
	},
	useskill1 = {
		totalframe = 35,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				id = 20620001,
				frame = 22,
				sound = {
					"huiwu",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 67,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 37,
				id = 20630001,
				sound = {
					"dun",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 67,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/20602.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 7,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 20,
				startframe = 6,
				anchory = 130
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 22,
				startframe = 33,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 67,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 37,
			id = 20631001,
			sound = {
				"dun",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 67,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/20601.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 7,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 20,
				startframe = 6,
				anchory = 130
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 22,
				startframe = 33,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp2 = {
	totalframe = 67,
	xpeffect = "xp_effect2",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 37,
			id = 20631101,
			sound = {
				"dun",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect2 = {
	totalframe = 67,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/20601.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 7,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 20,
				startframe = 6,
				anchory = 130
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 22,
				startframe = 33,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp3 = {
	totalframe = 67,
	xpeffect = "xp_effect3",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 37,
			id = 20632001,
			sound = {
				"dun",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect3 = {
	totalframe = 67,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/20602.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 7,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 20,
				startframe = 6,
				anchory = 130
			}
		}
	}
}
var_0_0.usexp4 = {
	totalframe = 67,
	xpeffect = "xp_effect4",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 37,
			id = 20640001,
			sound = {
				"dun",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect4 = {
	totalframe = 67,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "teammate"
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
			texture = "role/20610.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 7,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 20,
				startframe = 6,
				anchory = 130
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 22,
				startframe = 33,
				time = 0.1
			}
		}
	}
}

return var_0_0
