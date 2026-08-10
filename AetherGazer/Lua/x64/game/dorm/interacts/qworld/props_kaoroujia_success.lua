local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "barbecue_successed"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "barbecue_successed"
		}
	},
	[0.766666666666667] = {
		{
			attachPoint = "root",
			efxPath = "QWWorld/Effect/EmotionBubble/fx_canlan_0401",
			action = "playEfx",
			entity = 1,
			duration = 0,
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
	[3.33333333333333] = {
		{
			attachPoint = "root",
			action = "clearEfx",
			entity = 1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.766666666666667,
		3.33333333333333
	}
}

var_0_1.duration = 3.333333
var_0_1.fps = 30

return var_0_1
