local var_0_0 = {
	[0] = {
		{
			m_Time = 0,
			animeActionSubName = "01",
			action = "play",
			entity = 0,
			crossFade = 0.05,
			animeActionName = "saucepan"
		}
	},
	[0.833333333333333] = {
		{
			grabBy = 0,
			m_Time = 0.8333333,
			action = "grabPart",
			attachPoint = "gua_R_hand_bone",
			itemPartName = "item_pingguo",
			grabFrom = 1
		}
	},
	[1.03333333333333] = {
		{
			attachPoint = "gua_chaocai",
			m_Time = 1.033333,
			action = "playEfx",
			entity = 1,
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_chaocai",
			duration = 8.95
		}
	},
	[9.96666666666667] = {
		{
			itemPartHost = 1,
			itemPartName = "item_pingguo",
			action = "restorePart",
			m_Time = 9.966666
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.833333333333333,
		1.03333333333333,
		9.96666666666667
	}
}

var_0_1.duration = 11.63333
var_0_1.fps = 30

return var_0_1
