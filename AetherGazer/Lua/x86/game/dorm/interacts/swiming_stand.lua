local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "swiming_stand"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "swiming_stand"
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_swiming_stand",
			action = "playEfx",
			entity = 1,
			duration = 14.4
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0
	}
}

var_0_1.duration = 14.46667
var_0_1.fps = 30

return var_0_1
