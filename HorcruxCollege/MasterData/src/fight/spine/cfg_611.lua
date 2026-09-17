return {
	attack1 = {
		totalframe = 17,
		animation = "attack1",
		exe_tbl = {
			{
				id = 61110001,
				frame = 5,
				sound = {
					"horn_fire",
					0.4
				}
			}
		}
	},
	attack2 = {
		totalframe = 17,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 5,
				id = 61110001,
				effect = {
					{
						ani = "attack1",
						name = "61100_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"gunhit",
					0.4
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
	useskill1 = {
		totalframe = 28,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 61120001,
				frame = 16,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				},
				sound = {
					"horn_fire",
					0.4
				}
			}
		}
	},
	useskill2 = {
		totalframe = 28,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				id = 61120001,
				frame = 16,
				sound = {
					"boom",
					0.4
				}
			}
		}
	},
	usexp = {
		totalframe = 28,
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 24,
				id = 61130001,
				effect = {
					{
						ani = "attack_xp",
						name = "61100_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"horn_fire",
					0.4
				}
			},
			{
				frame = 26,
				id = 61130001,
				effect = {
					{
						ani = "attack_xp",
						name = "61100_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"horn_fire",
					0.4
				}
			},
			{
				frame = 27,
				id = 61130001,
				effect = {
					{
						ani = "attack_xp",
						name = "61100_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"horn_fire",
					0.4
				}
			}
		}
	}
}
