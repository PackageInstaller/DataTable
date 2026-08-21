local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "01",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "serve"
		},
		{
			m_Time = 0,
			scheme = "serve",
			action = "changeScheme",
			entity = 0
		}
	},
	[0.5] = {
		{
			grabBy = 0,
			m_Time = 0.5,
			action = "grabPart",
			attachPoint = "gua_R_hand_bone",
			itemPartName = "testItem",
			grabFrom = 1
		}
	},
	[1.51666666666667] = {
		{
			itemPartHost = 1,
			itemPartName = "testItem",
			action = "restorePart",
			m_Time = 1.516667
		}
	},
	[3] = {
		{
			m_Time = 3,
			referenceTarget = 1,
			action = "putAt",
			entity = 0,
			referencePointName = "gua_t2"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.5,
		1.51666666666667,
		3
	}
}

var_0_1.duration = 5
var_0_1.fps = 60

return var_0_1
