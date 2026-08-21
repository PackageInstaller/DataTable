local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "sofa_sit_thoth_start"
		},
		{
			referencePointName = "gua_sit_sofa",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[2.53333333333333] = {
		{
			animeActionSubName = "",
			crossFade = 0.03,
			action = "play",
			entity = 0,
			animeActionName = "sofa_sit_thoth"
		}
	},
	[13.9] = {
		{
			animeActionSubName = "",
			crossFade = 0.03,
			action = "play",
			entity = 0,
			animeActionName = "sofa_sit_thoth_end"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		2.53333333333333,
		13.9
	}
}

var_0_1.duration = 17.4
var_0_1.fps = 30

return var_0_1
