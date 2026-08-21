local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "phonograph"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "phonograph"
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9038_yingyue",
			action = "playEfx",
			entity = 0,
			duration = 16,
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
	[9.76666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9038_kaixing",
			action = "playEfx",
			entity = 0,
			duration = 6,
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
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		9.76666666666667
	}
}

var_0_1.duration = 15.73333
var_0_1.fps = 30

return var_0_1
