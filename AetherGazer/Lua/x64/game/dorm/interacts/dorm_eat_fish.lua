local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "eat"
		}
	},
	[0.2] = {
		{
			attachPoint = "gua_R_hand_bone",
			m_Time = 0.2,
			action = "playEfx",
			entity = 0,
			efxPath = "Effect/Dorm/food01",
			duration = 4.5
		}
	},
	[5.5] = {
		{
			attachPoint = "gua_R_hand_bone",
			m_Time = 5.5,
			action = "clearEfx",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.2,
		5.5
	}
}

var_0_1.duration = 6
var_0_1.fps = 30

return var_0_1
