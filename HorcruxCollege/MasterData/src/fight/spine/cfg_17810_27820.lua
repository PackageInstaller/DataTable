local var_0_0 = {
	xpeffect = {},
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"27820_attack",
					0.6
				}
			},
			{
				frame = 15,
				bullet = "attack1"
			}
		}
	},
	["attack-fly"] = {
		totalframe = 30,
		animation = "attack_fly",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack2",
				sound = {
					"27820_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"27820_attack",
					0.6
				}
			},
			{
				frame = 15,
				bullet = "heal1"
			}
		}
	},
	["attack2-fly"] = {
		totalframe = 30,
		animation = "attack_fly",
		exe_tbl = {
			{
				frame = 15,
				bullet = "heal2",
				sound = {
					"27820_attack",
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	skill1_fly = {
		{
			{
				method = "useSkill",
				param = "useskill1_fly"
			}
		}
	},
	useskill1 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27820_skill",
					0.6
				}
			},
			{
				frame = 38,
				effect = {
					{
						ani = "skill",
						name = "17810_27820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 42,
				id = 27820010
			},
			{
				frame = 46,
				id = 27820010
			},
			{
				frame = 50,
				id = 27820010
			},
			{
				frame = 54,
				id = 27820010
			},
			{
				frame = 60,
				id = 27820010
			}
		}
	},
	useskill1_fly = {
		totalframe = 45,
		animation = "skill_fly",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27820_skill",
					0.6
				}
			},
			{
				frame = 38,
				effect = {
					{
						ani = "skill",
						name = "17810_27820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 42,
				id = 27820010
			},
			{
				frame = 46,
				id = 27820010
			},
			{
				frame = 50,
				id = 27820010
			},
			{
				frame = 54,
				id = 27820010
			},
			{
				frame = 60,
				id = 27820010
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 105,
		animation = "xp",
		exe_tbl = {
			{
				frame = 0,
				sound = {
					"27820_xp",
					0.6
				}
			},
			{
				id = 27830010,
				frame = 55,
				effect = {
					{
						ani = "skill1",
						name = "17810_27820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 27830010,
				frame = 65,
				effect = {
					{
						ani = "skill2",
						name = "17810_27820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 27830010,
				frame = 75,
				effect = {
					{
						ani = "skill3",
						name = "17810_27820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 27830010,
				frame = 85,
				effect = {
					{
						ani = "skill4",
						name = "17810_27820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 27830010,
				frame = 95,
				effect = {
					{
						ani = "skill5",
						name = "17810_27820_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 105,
				id = 27830011
			},
			{
				frame = 23,
				id = 27820012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1.5,
	bgfile = "marry_bg",
	totalframe = 105,
	bgfileflipX = true,
	locktarget = {
		locktargetpool = "all"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/27820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/27820_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 70,
				startframe = 30
			}
		},
		move = {
			{
				distanceY = 50,
				totalframe = 85,
				startframe = 20,
				time = 1
			},
			{
				distance = 100,
				totalframe = 85,
				startframe = 20,
				time = 1
			},
			{
				distanceY = -50,
				totalframe = 10,
				startframe = 95,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "17810_27820_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 27810010,
				frame = 1
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "17810_27820_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 27810010,
				frame = 1
			}
		}
	}
}
var_0_0.extra.heal1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "17810_27820_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 27810011,
				frame = 1
			}
		}
	}
}
var_0_0.extra.heal2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "17810_27820_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 27810011,
				frame = 1
			}
		}
	}
}

return var_0_0
