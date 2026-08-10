local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "chess_read"
		},
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 1,
			animeActionName = "chess_read"
		},
		{
			referencePointName = "gua_start_sit",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9055_chess_read",
			action = "playEfx",
			entity = 1,
			duration = 17
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0
	}
}

var_0_1.duration = 19.66667
var_0_1.fps = 30

return var_0_1
