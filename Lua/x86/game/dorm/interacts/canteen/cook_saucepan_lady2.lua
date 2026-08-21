local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "02",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "saucepan"
		}
	},
	[1.06666666666667] = {
		{
			grabBy = 0,
			m_Time = 1.066667,
			action = "grabPart",
			attachPoint = "gua_L_hand_bone",
			itemPartName = "item_pingguo",
			grabFrom = 1
		},
		{
			attachPoint = "gua_pingguo",
			m_Time = 1.066667,
			action = "playEfx",
			entity = 1,
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_chaocai2",
			duration = 13
		}
	},
	[3.73333333333333] = {
		{
			itemPartHost = 1,
			itemPartName = "item_pingguo",
			action = "restorePart",
			m_Time = 3.733333
		}
	},
	[6.66666666666667] = {
		{
			attachPoint = "gua_conghua",
			m_Time = 6.666667,
			action = "playEfx",
			entity = 1,
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_cong",
			duration = 0.5
		}
	},
	[8] = {
		{
			grabBy = 0,
			m_Time = 8,
			action = "grabPart",
			attachPoint = "gua_L_hand_bone",
			itemPartName = "item_pingguo",
			grabFrom = 1
		}
	},
	[12.7333333333333] = {
		{
			attachPoint = "gua_conghua",
			m_Time = 12.73333,
			action = "clearEfx",
			entity = 1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1.06666666666667,
		3.73333333333333,
		6.66666666666667,
		8,
		12.7333333333333
	}
}

var_0_1.duration = 14.33333
var_0_1.fps = 30

return var_0_1
