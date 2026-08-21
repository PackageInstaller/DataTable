local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "03",
			action = "play",
			entity = 0,
			crossFade = 0.03,
			animeActionName = "stroke"
		}
	},
	[5.66666666666667] = {
		{
			attachPoint = "gua_biaoqing_bone",
			m_Time = 5.666667,
			action = "playEfx",
			entity = 0,
			efxPath = "Effect/Dorm/shy02",
			duration = 2
		}
	},
	[7.33333333333333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			m_Time = 7.333333,
			action = "clearEfx",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		5.66666666666667,
		7.33333333333333
	}
}

var_0_1.duration = 8.666667
var_0_1.fps = 30

return var_0_1
