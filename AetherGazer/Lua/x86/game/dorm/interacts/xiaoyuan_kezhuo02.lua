local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "03",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "student_chair"
		},
		{
			referencePointName = "gua_start_sit",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "03",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "student_chair"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0
	}
}

var_0_1.duration = 11.33333
var_0_1.fps = 30

return var_0_1
