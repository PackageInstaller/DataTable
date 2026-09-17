local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10090121,
				frame = 18
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 10090131,
				frame = 30,
				shake = {
					x = 0,
					y = 20
				},
				effect = {
					{
						ani = "skill",
						name = "100901_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 600
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
		totalframe = 60,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 24,
				bullet = "skill2",
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			},
			{
				frame = 26,
				bullet = "skill2",
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			},
			{
				frame = 28,
				bullet = "skill2",
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			},
			{
				frame = 30,
				bullet = "skill2",
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			},
			{
				frame = 32,
				bullet = "skill2",
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			},
			{
				frame = 34,
				bullet = "skill2"
			},
			{
				frame = 36,
				bullet = "skill2"
			},
			{
				frame = 38,
				bullet = "skill2"
			},
			{
				frame = 40,
				bullet = "skill2"
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
		totalframe = 70,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 45,
				forceY = {
					{
						speed = 1400
					}
				}
			},
			{
				id = 10090171,
				frame = 55,
				behitted = "hitdown",
				forceY = {
					{
						speed = -800
					}
				},
				shake = {
					x = 0,
					y = 20
				},
				effect = {
					{
						ani = "xp",
						name = "100901_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10090171,
				frame = 60,
				behitted = "hitdown",
				shake = {
					x = 0,
					y = 20
				},
				forceY = {
					{
						speed = -400
					}
				},
				effect = {
					{
						ani = "xp",
						name = "100901_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10090171,
				frame = 65,
				behitted = "hitdown",
				shake = {
					x = 0,
					y = 20
				},
				forceY = {
					{
						speed = -400
					}
				},
				effect = {
					{
						ani = "xp",
						name = "100901_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10090171,
				frame = 70,
				behitted = "hitdown",
				shake = {
					x = 0,
					y = 20
				},
				forceY = {
					{
						speed = -800
					}
				},
				effect = {
					{
						ani = "xp",
						name = "100901_effect",
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
	totalframe = 90,
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
var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100901_effect",
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
		totalframe = 20,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 4,
				id = 10090141
			}
		}
	}
}

return var_0_0
