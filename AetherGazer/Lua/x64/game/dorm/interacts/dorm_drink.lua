local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "drink01_female"
		}
	},
	[0.2] = {
		{
			attachPoint = "gua_R_hand_bone",
			efxPath = "Effect/Dorm/shuibei",
			action = "playEfx",
			entity = 0,
			duration = 14.5,
			offset = {
				z = 0,
				x = 0,
				y = 0
			},
			rotation = {
				w = 1,
				z = 0,
				x = 0,
				y = 0
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[14] = {
		{
			attachPoint = "gua_R_hand_bone",
			action = "clearEfx",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.2,
		14
	}
}

var_0_1.duration = 14.5
var_0_1.fps = 30

return var_0_1
