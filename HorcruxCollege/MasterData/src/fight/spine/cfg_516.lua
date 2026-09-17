return {
	attack = {
		totalframe = 36,
		animation = "attack",
		exe_tbl = {
			{
				id = 51610001,
				frame = 20,
				effect = {
					{
						ani = "b_attack",
						name = "attack_effect",
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
		totalframe = 55,
		animation = "skill",
		exe_tbl = {
			{
				id = 51620001,
				frame = 28,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "b_attack",
						name = "attack_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 97,
		animation = "xp",
		exe_tbl = {
			{
				frame = 57,
				id = 51630001,
				shake = {
					x = 0,
					y = 6
				},
				effect = {
					{
						ani = "b_attack",
						name = "attack_effect",
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
