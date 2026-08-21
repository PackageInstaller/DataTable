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
			animeActionName = "jack_kick"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "jack_kick"
		}
	},
	[2.06666666666667] = {
		{
			attachPoint = "gua_bone03",
			efxPath = "Dorm/Effect/houzhai/fx_nangua_jian",
			action = "playEfx",
			entity = 1,
			duration = 11.2,
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
	[9.3] = {
		{
			attachPoint = "gua_bone03",
			efxPath = "Dorm/Effect/houzhai/fx_nangua_ti",
			action = "playEfx",
			entity = 1,
			duration = 5,
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
		2.06666666666667,
		9.3
	}
}

var_0_1.duration = 13.16667
var_0_1.fps = 30

return var_0_1
