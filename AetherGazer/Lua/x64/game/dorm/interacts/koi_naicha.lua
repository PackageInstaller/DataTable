local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "KOI_naicha"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "KOI_naicha"
		}
	},
	[1.63333333333333] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_KOI_heart",
			action = "playEfx",
			entity = 1,
			duration = 6,
			offset = {
				z = 0.542,
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
	[5] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_KOI_manzu",
			action = "playEfx",
			entity = 1,
			duration = 4,
			offset = {
				z = 0.526,
				x = 0.1097,
				y = -0.453
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
		1.63333333333333,
		5
	}
}

var_0_1.duration = 8.466666
var_0_1.fps = 30

return var_0_1
