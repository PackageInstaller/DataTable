local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "2",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "snake_dance_"
		},
		{
			animeActionSubName = "2",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "snake_dance_"
		},
		{
			referencePointName = "root",
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

var_0_1.duration = 13.06667
var_0_1.fps = 30

return var_0_1
