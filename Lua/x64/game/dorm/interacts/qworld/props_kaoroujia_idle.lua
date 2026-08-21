local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "barbecue_start"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "barbecue_start"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0
	}
}

var_0_1.duration = 2
var_0_1.fps = 30

return var_0_1
