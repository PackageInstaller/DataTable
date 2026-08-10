local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "sit_up"
		},
		{
			m_Time = 0,
			scheme = "default",
			action = "changeScheme",
			entity = 0
		}
	},
	[5] = {
		{
			value = true,
			m_Time = 5,
			action = "setMobility",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		5
	}
}

var_0_1.duration = 5
var_0_1.fps = 60

return var_0_1
