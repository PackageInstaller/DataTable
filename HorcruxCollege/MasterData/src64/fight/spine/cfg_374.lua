local var_0_0 = {
	attack = {
		totalframe = 21,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				effect = {
					{
						ani = "attack_tx",
						name = "37400_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "self"
					}
				}
			},
			{
				id = 37410001,
				frame = 11
			},
			{
				id = 37410001,
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
		totalframe = 19,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				effect = {
					{
						ani = "skill1_tx",
						name = "37400_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "self"
					}
				}
			},
			{
				id = 37420001,
				frame = 11
			}
		}
	},
	useskill2 = {
		totalframe = 48,
		animation = "skill2",
		exe_tbl = {
			{
				id = 37430001,
				frame = 12,
				shake = {
					x = 4,
					y = 0
				},
				effect = {
					{
						ani = "skill2_tx",
						name = "37400_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "self"
					}
				}
			}
		}
	},
	useskill3 = {
		totalframe = 24,
		animation = "skill3",
		exe_tbl = {
			{
				id = 37440001,
				frame = 2,
				effect = {
					{
						ani = "skill3_tx",
						name = "37400_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "self"
					}
				},
				shake = {
					x = 0,
					y = 0
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
	usexp = {
		xpeffect = "xp_effect",
		totalframe = 167,
		animation = "xp",
		changeattachment = {
			attachment = "bingren",
			slot = "body/bingren"
		},
		exe_tbl = {
			{
				id = 37450001,
				frame = 1,
				shake = {
					x = 5,
					y = 0
				},
				effect = {
					{
						ani = "xp_tx",
						name = "37400_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "self"
					}
				}
			},
			{
				id = 37420001,
				frame = 150,
				forceY = {
					{
						distance = 2000,
						time = 4.2
					}
				},
				shake = {
					x = 0,
					y = 10
				}
			},
			{
				frame = 165,
				id = 37460002
			},
			{
				frame = 35,
				sound = {
					"20200_xp1",
					0.6
				}
			},
			{
				frame = 55,
				sound = {
					"20200_xp1",
					0.6
				}
			},
			{
				frame = 75,
				sound = {
					"20000_skill",
					0.6
				}
			},
			{
				frame = 110,
				sound = {
					"20500_attack",
					0.6
				}
			},
			{
				frame = 151,
				sound = {
					"20500_xp2",
					0.7
				}
			}
		}
	},
	xpeffect = {}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 152,
	bgfile = "37400_BG",
	locktarget = {
		locktarget = true
	},
	bgani = {
		{
			isloop = true,
			startframe = 1,
			ani = "BG"
		}
	},
	show = {
		{
			action = "show",
			startframe = 1,
			target = "self"
		}
	},
	show = {
		{
			action = "show",
			startframe = 150,
			target = "locktarget"
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.7,
				totalframe = 57,
				startframe = 110
			}
		},
		move = {
			{
				distance = 50,
				totalframe = 151,
				startframe = 1,
				time = 0.1
			}
		}
	}
}

return var_0_0
