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
			animeActionName = "pirate_bucket"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "pirate_bucket"
		},
		{
			attachPoint = "gua_start",
			efxPath = "Dorm/Effect/houzhai/fx_hz_haidao_1",
			action = "playEfx",
			entity = 1,
			duration = 10,
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
			attachPoint = "gua_bone002",
			efxPath = "Dorm/Effect/houzhai/fx_hz_haidao_2",
			action = "playEfx",
			entity = 1,
			duration = 10,
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
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_hz_haidao_3",
			action = "playEfx",
			entity = 0,
			duration = 10,
			offset = {
				z = -0.09940815,
				x = 0,
				y = -0.08774187
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
		},
		{
			attachPoint = "gua_bone004",
			efxPath = "Dorm/Effect/houzhai/fx_hz_haidao_5",
			action = "playEfx",
			entity = 1,
			duration = 10,
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
		0
	}
}

var_0_1.duration = 15.46667
var_0_1.fps = 30

return var_0_1
