local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "kick_box"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[0.533333333333333] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "open_box"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.533333333333333
	}
}

var_0_1.duration = 1.633333
var_0_1.fps = 30

return var_0_1
