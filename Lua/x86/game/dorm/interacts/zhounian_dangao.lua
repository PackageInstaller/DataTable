local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "anniversary_cake"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "anniversary_cake"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[3.8] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_zhounian2_dangao",
			action = "playEfx",
			entity = 1,
			duration = 3,
			offset = {
				z = 0,
				x = -0.027,
				y = 0.859
			},
			rotation = {
				w = -0.5,
				z = -0.5,
				x = 0.5,
				y = -0.5
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
		3.8
	}
}

var_0_1.duration = 6.066667
var_0_1.fps = 30

return var_0_1
