local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start1",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "open_box"
		}
	},
	[0.0666666666666667] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "open_box"
		}
	},
	[0.866666666666667] = {
		{
			attachPoint = "gua_fx_interact",
			efxPath = "QWWorld/Effect/fx_box_open_2",
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
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.0666666666666667,
		0.866666666666667
	}
}

var_0_1.duration = 2.166667
var_0_1.fps = 30

return var_0_1
