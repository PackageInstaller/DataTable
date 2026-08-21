local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.01,
			animeActionName = "zongzisofa_sit_up"
		},
		{
			m_Time = 0,
			animeActionSubName = "",
			action = "play",
			entity = 1,
			crossFade = 0.05,
			animeActionName = "sit_up"
		}
	},
	[1.76666666666667] = {
		{
			m_Time = 1.766667,
			scheme = "default",
			action = "changeScheme",
			entity = 0
		},
		{
			value = true,
			m_Time = 1.766667,
			action = "setMobility",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1.76666666666667
	}
}

var_0_1.duration = 1.766667
var_0_1.fps = 30

return var_0_1
