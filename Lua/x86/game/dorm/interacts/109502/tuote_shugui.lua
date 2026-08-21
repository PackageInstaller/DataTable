local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "book_shelf_thoth"
		},
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 1,
			animeActionName = "book_shelf_thoth"
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

var_0_1.duration = 12.2
var_0_1.fps = 30

return var_0_1
