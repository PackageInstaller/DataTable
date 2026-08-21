local var_0_0 = {
	[0] = {
		{
			referencePointName = "root",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "diary_read"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "diary_read"
		}
	},
	[2.8] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_hz_9019_sikao",
			action = "playEfx",
			entity = 1,
			duration = 5,
			offset = {
				z = 0.983,
				x = 0,
				y = 0
			},
			rotation = {
				w = -0.5,
				z = 0.5,
				x = -0.5,
				y = 0.5
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[4.76666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_hz_9019_fanshu",
			action = "playEfx",
			entity = 1,
			duration = 5,
			offset = {
				z = 0.462,
				x = -0.229,
				y = -0.09159
			},
			rotation = {
				w = 0.5,
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
	},
	[9.3] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_hz_9019_haixiu",
			action = "playEfx",
			entity = 1,
			duration = 5,
			offset = {
				z = 0,
				x = 0,
				y = 0
			},
			rotation = {
				w = -0.5,
				z = 0.5,
				x = -0.5,
				y = 0.5
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
		2.8,
		4.76666666666667,
		9.3
	}
}

var_0_1.duration = 16.43333
var_0_1.fps = 30

return var_0_1
