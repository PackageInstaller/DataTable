local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "steamer"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "steamer_male"
		}
	},
	[1.33333333333333] = {
		{
			attachPoint = "gua_smoke",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_ZL_male_smoke1",
			action = "playEfx",
			entity = 1,
			duration = 3.13
		}
	},
	[5.4] = {
		{
			attachPoint = "gua_smoke",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_ZL_male_smoke2",
			action = "playEfx",
			entity = 1,
			duration = 4
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1.33333333333333,
		5.4
	}
}

var_0_1.duration = 10.66667
var_0_1.fps = 30

return var_0_1
