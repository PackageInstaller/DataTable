local var_0_0 = {
	[0.166666666666667] = {
		{
			faceEmoteSubState = "",
			m_Time = 0.1666667,
			action = "setFace",
			entity = 0,
			faceEmoteState = "happy",
			crossFade = 0.05
		},
		{
			value = 31,
			m_Time = 0.1666667,
			action = "setMouth",
			entity = 0
		}
	},
	[3.23333333333333] = {
		{
			m_Time = 3.233333,
			subtitleID = 0,
			action = "playSubtitle",
			entity = 0
		},
		{
			value = 0,
			m_Time = 3.233333,
			action = "setMouth",
			entity = 0
		}
	},
	[3.98333333333333] = {
		{
			faceEmoteSubState = "",
			m_Time = 3.983333,
			action = "setFace",
			entity = 0,
			faceEmoteState = "blink",
			crossFade = 0.05
		}
	},
	[5.66666666666667] = {
		{
			m_Time = 5.666667,
			subtitleID = 1011,
			action = "playSubtitle",
			entity = 0
		},
		{
			m_Time = 5.666667,
			action = "setSpFace",
			entity = 0,
			duration = 1.5,
			faceEfxPath = "Effect/Dorm/laugh02"
		}
	},
	[6.66666666666667] = {
		{
			m_Time = 6.666667,
			subtitleID = 2011,
			action = "playSubtitle",
			entity = 0
		}
	},
	[7] = {
		{
			m_Time = 7,
			action = "setSpFace",
			entity = 0,
			duration = 1,
			faceEfxPath = "Effect/Dorm/shocked04"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0.166666666666667,
		3.23333333333333,
		3.98333333333333,
		5.66666666666667,
		6.66666666666667,
		7
	}
}

var_0_1.duration = 10
var_0_1.fps = 60

return var_0_1
