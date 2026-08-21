local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "2",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "fortune_stall_idle2"
		},
		{
			animeActionSubName = "2",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "fortune_stall_idle2"
		}
	},
	[5.5] = {
		{
			attachPoint = "gua_fx",
			efxPath = "Dorm/Effect/houzhai/fx_9072_stall_idle2_glo",
			action = "playEfx",
			entity = 1,
			duration = 2.93,
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
	[6.23333333333333] = {
		{
			attachPoint = "gua_fx",
			efxPath = "Dorm/Effect/houzhai/fx_9072_stall_idle2",
			action = "playEfx",
			entity = 1,
			duration = 2.2,
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
	[13.3666666666667] = {
		{
			attachPoint = "gua_fx",
			action = "clearEfx",
			entity = 1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		5.5,
		6.23333333333333,
		13.3666666666667
	}
}

var_0_1.duration = 13.36667
var_0_1.fps = 30

return var_0_1
