local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "chair1_sit_down"
		},
		{
			m_Time = 0,
			animeActionSubName = "",
			action = "play",
			entity = 1,
			crossFade = 0.05,
			animeActionName = "chair1_sit_down"
		}
	},
	[1.26666666666667] = {
		{
			m_Time = 1.266667,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "chair1_sit_stand"
		},
		{
			m_Time = 1.266667,
			animeActionSubName = "",
			action = "play",
			entity = 1,
			crossFade = 0.05,
			animeActionName = "chair1_sit_stand"
		}
	},
	[3.3] = {
		{
			m_Time = 3.3,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "chair1_sit_idle"
		},
		{
			m_Time = 3.3,
			animeActionSubName = "",
			action = "play",
			entity = 1,
			crossFade = 0.05,
			animeActionName = "chair1_sit_idle"
		}
	},
	[9.06666666666667] = {
		{
			m_Time = 9.066667,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "chair1_sit_up"
		},
		{
			m_Time = 9.066667,
			animeActionSubName = "",
			action = "play",
			entity = 1,
			crossFade = 0.05,
			animeActionName = "chair1_sit_up"
		}
	},
	[10.0333333333333] = {
		{
			m_Time = 10.03333,
			referenceTarget = 1,
			action = "putAt",
			entity = 0,
			referencePointName = "gua_start_sit"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1.26666666666667,
		3.3,
		9.06666666666667,
		10.0333333333333
	}
}

var_0_1.duration = 11.46667
var_0_1.fps = 30

return var_0_1
