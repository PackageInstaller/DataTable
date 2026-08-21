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
			entity = 1,
			animeActionName = "mirror"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "mirror"
		},
		{
			attachPoint = "gua_fx01",
			efxPath = "Dorm/Effect/houzhai/fx_9049_jingzi",
			action = "playEfx",
			entity = 1,
			duration = 14,
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
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9049",
			action = "playEfx",
			entity = 0,
			duration = 14,
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
		},
		{
			attachPoint = "gua_start",
			efxPath = "Dorm/Effect/houzhai/fx_9049_youling",
			action = "playEfx",
			entity = 1,
			duration = 14,
			offset = {
				z = 0.80266,
				x = 0,
				y = 0
			},
			rotation = {
				w = -4.371139e-08,
				z = 0,
				x = 0,
				y = -1
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
		0
	}
}

var_0_1.duration = 13.46667
var_0_1.fps = 30

return var_0_1
