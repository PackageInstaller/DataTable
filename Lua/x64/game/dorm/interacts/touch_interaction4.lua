local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "01",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "angry"
		}
	},
	[0.2] = {
		{
			m_Time = 0.2,
			action = "setSpFace",
			entity = 0,
			duration = 1.733,
			faceEfxPath = "Effect/Dorm/discomfort01"
		},
		{
			value = 1,
			m_Time = 0.2,
			action = "setMouth",
			entity = 0
		}
	},
	[0.4] = {
		{
			value = 17,
			m_Time = 0.4,
			action = "setMouth",
			entity = 0
		}
	},
	[1.93333333333333] = {
		{
			value = 0,
			m_Time = 1.933333,
			action = "setMouth",
			entity = 0
		}
	},
	[2.96666666666667] = {
		{
			value = 17,
			m_Time = 2.966667,
			action = "setMouth",
			entity = 0
		},
		{
			m_Time = 2.966667,
			action = "setSpFace",
			entity = 0,
			duration = 0.7,
			faceEfxPath = "Effect/Dorm/discomfort01"
		}
	},
	[3.7] = {
		{
			value = 0,
			m_Time = 3.7,
			action = "setMouth",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.2,
		0.4,
		1.93333333333333,
		2.96666666666667,
		3.7
	}
}

var_0_1.duration = 4.366667
var_0_1.fps = 30

return var_0_1
