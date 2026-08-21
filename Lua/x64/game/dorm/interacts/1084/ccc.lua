local var_0_0 = {
	[0.816666666666667] = {
		{
			grabBy = 0,
			m_Time = 0.8166667,
			action = "grabPart",
			attachPoint = "gua_R_hand_bone",
			itemPartName = "itemTest",
			grabFrom = 1
		}
	},
	[2.25] = {
		{
			itemPartHost = 1,
			itemPartName = "itemTest",
			action = "restorePart",
			m_Time = 2.25
		}
	},
	[4.16666666666667] = {
		{
			m_Time = 4.166667,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "oven"
		},
		{
			m_Time = 4.166667,
			animeActionSubName = "",
			action = "play",
			entity = 1,
			crossFade = 0.05,
			animeActionName = "oven"
		}
	},
	[4.86666666666667] = {
		{
			m_Time = 4.866667,
			referenceTarget = 1,
			action = "putAt",
			entity = 0,
			referencePointName = "gua_start"
		}
	},
	[5.25] = {
		{
			m_Time = 5.25,
			scheme = "sit",
			action = "changeScheme",
			entity = 0
		}
	},
	[10] = {
		{
			playerType = 1,
			name = "bbb",
			action = "playVoice",
			sheet = "aaa",
			m_Time = 10,
			awb = "ccc"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0.816666666666667,
		2.25,
		4.16666666666667,
		4.86666666666667,
		5.25,
		10
	}
}

var_0_1.duration = 10
var_0_1.fps = 60

return var_0_1
