local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "01",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "saucepan"
		},
		{
			attachPoint = "gua_pingguo",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_JG_male_cai",
			action = "playEfx",
			entity = 1,
			duration = 9.67
		}
	},
	[2.93333333333333] = {
		{
			attachPoint = "gua_pingguo",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_JG_male_cong",
			action = "playEfx",
			entity = 1,
			duration = 0.73
		}
	},
	[3.86666666666667] = {
		{
			grabBy = 0,
			attachPoint = "gua_R_hand_bone",
			action = "grabPart",
			itemPartName = "item_pingguo",
			grabFrom = 1
		}
	},
	[9.36666666666667] = {
		{
			attachPoint = "gua_pingguo",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_JG_male_smoke",
			action = "playEfx",
			entity = 1,
			duration = 1.8
		}
	},
	[9.53333333333333] = {
		{
			itemPartHost = 1,
			itemPartName = "item_pingguo",
			action = "restorePart"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		2.93333333333333,
		3.86666666666667,
		9.36666666666667,
		9.53333333333333
	}
}

var_0_1.duration = 10.7
var_0_1.fps = 30

return var_0_1
