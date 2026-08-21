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
			animeActionName = "steamer_female"
		}
	},
	[4.56666666666667] = {
		{
			attachPoint = "gua_smoke",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_ZLsmoke",
			action = "playEfx",
			entity = 1,
			duration = 1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		4.56666666666667
	}
}

var_0_1.duration = 10.33333
var_0_1.fps = 30

return var_0_1
