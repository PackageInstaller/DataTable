local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "eat"
		}
	},
	[0.5] = {
		{
			attachPoint = "gua_R_hand_bone",
			efxPath = "Effect/Dorm/food01",
			action = "playEfx",
			entity = 0,
			duration = 4.5,
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
	[5.5] = {
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
		0.5,
		5.5
	}
}

var_0_1.duration = 6
var_0_1.fps = 30

return var_0_1
