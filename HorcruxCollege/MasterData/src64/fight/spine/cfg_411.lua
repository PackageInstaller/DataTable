local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 10,
				id = 41110001,
				effect = {
					{
						ani = "attack",
						name = "41100_effect",
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
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 6,
				id = 41110001,
				effect = {
					{
						ani = "attack2",
						name = "41100_effect",
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 35,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 10,
				id = 41120001,
				effect = {
					{
						ani = "attack",
						name = "41100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 18,
				id = 41120001,
				effect = {
					{
						ani = "attack",
						name = "41100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 26,
				id = 41120001,
				effect = {
					{
						ani = "attack",
						name = "41100_effect",
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
		animation = "skill2",
		exe_tbl = {
			{
				id = 41121001,
				frame = 16,
				effect = {
					{
						ani = "skill2_attack",
						name = "41100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 4
				}
			},
			{
				frame = 16,
				id = 41121002
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 102,
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
			texture = "role/41105.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 89,
			timescale = 0.1
		}
	},
	camera = {
		move = {
			{
				pos = "target",
				totalframe = 70,
				startframe = 30,
				time = 0.1
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
	totalframe = 103,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "20600_skill"
		},
		{
			frame = 33,
			sound = "20200_attack",
			id = 41110001,
			effect = {
				{
					ani = "attack",
					name = "41100_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			frame = 39,
			sound = "20200_attack",
			id = 41110001,
			effect = {
				{
					ani = "attack",
					name = "41100_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			frame = 49,
			sound = "20200_attack",
			id = 41110001,
			effect = {
				{
					ani = "attack",
					name = "41100_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			frame = 64,
			sound = "20200_attack",
			id = 41110001,
			effect = {
				{
					ani = "skill2_attack",
					name = "41100_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			shake = {
				x = 4,
				y = 4
			}
		},
		{
			frame = 91,
			sound = "20800_attack",
			id = 41130002,
			behitted = "hitdown",
			effect = {
				{
					ani = "skill2_attack",
					name = "41100_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			shake = {
				x = 4,
				y = 4
			}
		}
	}
}

return var_0_0
