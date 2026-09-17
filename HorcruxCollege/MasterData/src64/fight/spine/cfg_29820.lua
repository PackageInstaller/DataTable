local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"29820_attack_01",
					0.6
				}
			},
			{
				id = 29810010,
				frame = 12,
				effect = {
					{
						ani = "attack1",
						name = "29820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"29820_attack_01",
					0.6
				}
			},
			{
				id = 29810011,
				frame = 12,
				effect = {
					{
						ani = "attack2",
						name = "29820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack3 = {
		{
			{
				method = "useSkill",
				param = "attack3_1"
			}
		}
	},
	attack3_1 = {
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 25,
		animation = "attack",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"29820_attack_01",
					0.6
				}
			},
			{
				id = 29810012,
				frame = 16,
				effect = {
					{
						ani = "attack1",
						name = "29820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack4 = {
		{
			{
				method = "useSkill",
				param = "attack4_1"
			}
		}
	},
	attack4_1 = {
		totalframe = 25,
		animation = "attack2",
		action_on_start = {
			{
				startframe = 20,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -100,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 14,
				sound = {
					"29820_attack_01",
					0.6
				}
			},
			{
				frame = 14,
				id = 29810014
			},
			{
				id = 29810013,
				frame = 15,
				bghitted = "hitdown",
				effect = {
					{
						ani = "attack2",
						name = "29820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack5 = {
		{
			{
				method = "useSkill",
				param = "attack5_1"
			}
		}
	},
	attack5_1 = {
		totalframe = 25,
		animation = "attack2",
		action_on_start = {
			{
				startframe = 20,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -50,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 14,
				sound = {
					"29820_attack_01",
					0.6
				}
			},
			{
				frame = 14,
				id = 29810014
			},
			{
				id = 29810013,
				frame = 15,
				bghitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "29820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
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
		turnbacklimit = true,
		totalframe = 35,
		animation = "skill",
		action_on_start = {
			{
				startframe = 10,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
							time = 0.4
						}
					}
				}
			},
			{
				startframe = 30,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -300,
							time = 0.4
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29820_skill_01",
					0.6
				}
			},
			{
				frame = 1,
				id = 29820012
			},
			{
				frame = 10,
				id = 29820010
			},
			{
				frame = 18,
				id = 29820010
			},
			{
				frame = 20,
				id = 29820010
			},
			{
				frame = 35,
				bullet = "skill1"
			}
		}
	}
}

var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 500,
	movingtype = "lockdirection",
	speed = 600,
	offsetZ = 1,
	filename = "29820_effect",
	initpos = {
		offsetY = 0,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		exe_tbl = {
			{
				id = 29820011,
				frame = 5,
				effect = {
					{
						ani = "skill",
						name = "29820_effect",
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
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 100,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"29820_xp_01",
				0.6
			}
		},
		{
			behitted = "hitdown",
			id = 29830010,
			frame = 27,
			effect = {
				{
					ani = "xp",
					name = "29820_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			forceY = {
				{
					distance = 100,
					time = 0.5
				}
			}
		},
		{
			behitted = "hitdown",
			id = 29830010,
			frame = 44,
			effect = {
				{
					ani = "xp",
					name = "29820_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			forceY = {
				{
					distance = -75,
					time = 0.8
				}
			}
		},
		{
			behitted = "hitdown",
			id = 29830010,
			frame = 69,
			effect = {
				{
					ani = "xp",
					name = "29820_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			forceY = {
				{
					distance = 25,
					time = 0.5
				}
			}
		},
		{
			id = 29830012,
			behitted = "hitdown",
			frame = 78,
			forceY = {
				{
					distance = 75,
					time = 0.3
				}
			}
		},
		{
			id = 29830010,
			frame = 91,
			effect = {
				{
					ani = "xp",
					name = "29820_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			forceY = {
				{
					distance = 100,
					time = 0.2
				}
			}
		},
		{
			id = 29830011,
			frame = 92,
			behitted = "hitdown",
			effect = {
				{
					ani = "skill",
					name = "29820_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 2,
	totalframe = 100,
	bgfile = "29820_bg",
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktargetpool = "oponent"
	},
	inserteffect = {
		{
			texture = "role/29820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/29820_xp",
				1
			}
		}
	},
	camera = {
		zoom = {
			{
				scale = 1,
				totalframe = 30,
				startframe = 90
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 30,
				startframe = 90,
				time = 2
			}
		},
		moveY = {
			{
				distance = 200,
				totalframe = 30,
				startframe = 90,
				time = 2
			}
		}
	}
}

return var_0_0
