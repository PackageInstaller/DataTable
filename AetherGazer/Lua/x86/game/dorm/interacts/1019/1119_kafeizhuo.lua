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
			animeActionName = "coffee_time"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "coffee_time"
		}
	},
	[1.06666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9119_shuijiao",
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
	},
	[5.8] = {
		{
			attachPoint = "gua_bone001",
			efxPath = "Dorm/Effect/houzhai/fx_9119_reqi",
			action = "playEfx",
			entity = 1,
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
	},
	[8.86666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9119_jiaxue",
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
	},
	[10.4] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9119_gantan",
			action = "playEfx",
			entity = 0,
			duration = 6,
			offset = {
				z = -0.127,
				x = -0.064,
				y = 0.94
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
	[13.2333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9119_zhenfen",
			action = "playEfx",
			entity = 0,
			duration = 6,
			offset = {
				z = 0.2,
				x = -0.409,
				y = 0
			},
			rotation = {
				w = -4.371139e-08,
				z = 0,
				x = 0,
				y = 1
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
		1.06666666666667,
		5.8,
		8.86666666666667,
		10.4,
		13.2333333333333
	}
}

var_0_1.duration = 16.16667
var_0_1.fps = 30

return var_0_1
