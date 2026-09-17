local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 20,
				bullet = "attack"
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
				frame = 10,
				id = 10089131,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "100891_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				},
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 130,
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
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -200,
							time = 0.3
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 20,
				id = 10089141
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
		xpeffect = "xp_effect",
		totalframe = 56,
		animation = "xp",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -200,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10089162,
				frame = 32
			},
			{
				id = 10089161,
				behitted = "hitdown",
				frame = 37
			},
			{
				id = 10089161,
				behitted = "hitdown",
				frame = 40
			},
			{
				id = 10089161,
				behitted = "hitdown",
				frame = 43
			},
			{
				id = 10089161,
				behitted = "hitdown",
				frame = 46
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 60,
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
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 13,
				startframe = 1
			}
		},
		move = {
			{
				distance = 150,
				time = 0.3,
				distanceY = 0,
				totalframe = 25,
				startframe = 30
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100891_effect",
	initpos = {
		offsetY = 1.3,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10089121,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "100891_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
