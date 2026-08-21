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
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "catsofa_sleep"
		},
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9045_yun1",
			action = "playEfx",
			entity = 1,
			duration = 307,
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
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "catsofa_sleep"
		}
	},
	[7.46666666666667] = {
		{
			attachPoint = "gua_head",
			efxPath = "Dorm/Effect/houzhai/fx_9045_yanwenzi",
			action = "playEfx",
			entity = 0,
			duration = 54,
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
			attachPoint = "gua_head",
			efxPath = "Dorm/Effect/houzhai/fx_9045_yun3",
			action = "playEfx",
			entity = 0,
			duration = 274,
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
	[8.83333333333333] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9045_yun2",
			action = "playEfx",
			entity = 1,
			duration = 151,
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
	[14.6666666666667] = {
		{
			attachPoint = "gua_head",
			efxPath = "Dorm/Effect/houzhai/fx_9045_yanwenzi1",
			action = "playEfx",
			entity = 0,
			duration = 37,
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
		7.46666666666667,
		8.83333333333333,
		14.6666666666667
	}
}

var_0_1.duration = 19.33333
var_0_1.fps = 30

return var_0_1
