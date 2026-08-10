local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "02",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "train_carriage"
		},
		{
			attachPoint = "gua_start",
			attachTo = 1,
			itemEntity = 0,
			action = "attachTo"
		}
	},
	[0.0666666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_huoche_xue1",
			action = "playEfx",
			entity = 0,
			duration = 3.4,
			offset = {
				z = 0,
				x = 0,
				y = 0
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
	},
	[2.93333333333333] = {
		{
			attachPoint = "gua_R_hand",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_huoche_xue3",
			action = "playEfx",
			entity = 0,
			duration = 1,
			offset = {
				z = -0.004,
				x = -0.015,
				y = 0.02
			},
			rotation = {
				w = -0.3947538,
				z = -0.9171315,
				x = 0.05219024,
				y = 0.01775402
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[3.1] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_huoche_xue2",
			action = "playEfx",
			entity = 0,
			duration = 0.8,
			offset = {
				z = 0,
				x = 0,
				y = 0
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
		0.0666666666666667,
		2.93333333333333,
		3.1
	}
}

var_0_1.duration = 4.266667
var_0_1.fps = 30

return var_0_1
