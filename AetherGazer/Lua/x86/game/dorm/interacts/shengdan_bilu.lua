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
			animeActionName = "fireplace_hot"
		}
	},
	[3.36666666666667] = {
		{
			attachPoint = "gua_start",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_shengdan_bilu_gua_start",
			action = "playEfx",
			entity = 1,
			duration = 7.2,
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
	[3.76666666666667] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_shengdan_bilu_head",
			action = "playEfx",
			entity = 0,
			duration = 11.16667,
			offset = {
				z = -0.09940813,
				x = 0,
				y = -0.08774196
			},
			rotation = {
				w = -0.4770452,
				z = 0.5219462,
				x = -0.5219462,
				y = 0.4770452
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
		3.36666666666667,
		3.76666666666667
	}
}

var_0_1.duration = 18.9
var_0_1.fps = 30

return var_0_1
