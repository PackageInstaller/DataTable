local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start_sit",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[0.0333333333333333] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "chair2_lie"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "chair2_lie"
		}
	},
	[6.03333333333333] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "chair2_stand"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "chair2_stand"
		},
		{
			scheme = "chair2_no_idle",
			action = "changeScheme",
			entity = 0
		},
		{
			value = false,
			action = "setMobility",
			entity = 0
		}
	},
	[7.5] = {
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
		0.0333333333333333,
		6.03333333333333,
		7.5
	}
}

var_0_1.duration = 7.533333
var_0_1.fps = 30

return var_0_1
