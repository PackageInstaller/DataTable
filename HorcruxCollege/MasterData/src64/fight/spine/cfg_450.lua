local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 15,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450100-attack",
					0.6
				}
			},
			{
				frame = 8,
				id = 45010001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
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
		totalframe = 15,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450100-attack",
					0.6
				}
			},
			{
				frame = 8,
				id = 45010001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack = {
		totalframe = 15,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450100-attack",
					0.6
				}
			},
			{
				frame = 8,
				id = 45010001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
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
		totalframe = 28,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450200-skill1",
					0.6
				}
			},
			{
				frame = 8,
				id = 45020001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 14,
				id = 45020001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 20,
				id = 45020001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 30,
		animation = "skill2_1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450210-skill2",
					0.6
				}
			},
			{
				frame = 7,
				id = 45021001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 12,
				id = 45021001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 17,
				id = 45021001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 22,
				id = 45021001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 26,
				id = 45021001,
				effect = {
					{
						ani = "attack",
						name = "45000_effect",
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
		totalframe = 21,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"450220-skill3",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 45022001,
				frame = 15,
				shake = {
					x = 0,
					y = 4
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
	bgfile = "45000_bg",
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
			texture = "role/45000.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 25,
				startframe = 15
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 25,
				startframe = 15,
				time = 0.1
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "qianyao"
		}
	}
}
var_0_0.qianyao = {
	totalframe = 22,
	nextani = true,
	animation = "win",
	action_on_start = {
		{
			startframe = 1,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = -50,
						time = 0.33
					}
				}
			}
		}
	},
	xpeffect = {
		conf = "xp_effect",
		startframe = 30
	},
	exe_tbl = {
		{
			id = 44900000,
			frame = 1,
			sound = {
				"invalid",
				1.6
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 51,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"450300-xp",
				0.6
			}
		},
		{
			id = 45030001,
			frame = 20,
			shake = {
				x = 0,
				y = 4
			},
			effect = {
				{
					ani = "skill1_attack",
					name = "45000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 45030001,
			frame = 22,
			shake = {
				x = 0,
				y = 4
			},
			effect = {
				{
					ani = "skill1_attack",
					name = "45000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 45030001,
			frame = 24,
			shake = {
				x = 0,
				y = 4
			},
			effect = {
				{
					ani = "skill1_attack",
					name = "45000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 45030001,
			frame = 26,
			shake = {
				x = 0,
				y = 4
			},
			effect = {
				{
					ani = "skill1_attack",
					name = "45000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 45030001,
			frame = 28,
			shake = {
				x = 0,
				y = 4
			},
			effect = {
				{
					ani = "skill1_attack",
					name = "45000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		},
		{
			id = 45030002,
			frame = 40,
			shake = {
				x = 4,
				y = 4
			}
		}
	}
}

return var_0_0
