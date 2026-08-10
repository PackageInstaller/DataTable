local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 1,
			animeActionName = "car_drive"
		},
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "car_drive"
		},
		{
			attachPoint = "gua_sit",
			attachTo = 1,
			itemEntity = 0,
			action = "attachTo"
		},
		{
			attachPoint = "gua_sit",
			efxPath = "Dorm/Effect/houzhai/fx_9081_pinmu",
			action = "playEfx",
			entity = 1,
			duration = 13
		},
		{
			attachPoint = "gua_fx_qiu",
			efxPath = "Dorm/Effect/houzhai/fx_9081_qiu",
			action = "playEfx",
			entity = 1,
			duration = 13
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0
	}
}

var_0_1.duration = 13.06667
var_0_1.fps = 30

return var_0_1
