local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "chair1_sit_down"
		}
	},
	[2.3] = {
		{
			m_Time = 2.3,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "chair1_sit_stand"
		},
		{
			m_Time = 2.3,
			scheme = "chair_sit_no_idle",
			action = "changeScheme",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		2.3
	}
}

var_0_1.duration = 2.333333
var_0_1.fps = 30

return var_0_1
