local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "zongzisofa_sit_down"
		},
		{
			animeActionSubName = "",
			crossFade = 0.03,
			action = "play",
			entity = 1,
			animeActionName = "sit_down"
		},
		{
			referencePointName = "gua_start_sit",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[3.66666666666667] = {
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "zongzisofa_sit_stand"
		},
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 1,
			animeActionName = "sit_stand"
		},
		{
			scheme = "zongzi_sofa",
			action = "changeScheme",
			entity = 0
		},
		{
			value = false,
			action = "setMobility",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		3.66666666666667
	}
}

var_0_1.duration = 5.666667
var_0_1.fps = 30

return var_0_1
