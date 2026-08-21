local var_0_0 = {
	[0.1] = {
		{
			m_Time = 0.1,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "bed_lie"
		}
	},
	[6.26666666666667] = {
		{
			m_Time = 6.266667,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "bed_stand"
		}
	},
	[16.3] = {
		{
			m_Time = 16.3,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "bed_wake"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0.1,
		6.26666666666667,
		16.3
	}
}

var_0_1.duration = 21.4
var_0_1.fps = 30

return var_0_1
