local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "02",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "saucepan"
		}
	},
	[1.06666666666667] = {
		{
			grabBy = 0,
			attachPoint = "gua_L_hand_bone",
			action = "grabPart",
			itemPartName = "item_pingguo",
			grabFrom = 1
		},
		{
			attachPoint = "gua_pingguo",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_chaocai2",
			action = "playEfx",
			entity = 1,
			duration = 13
		}
	},
	[3.73333333333333] = {
		{
			itemPartHost = 1,
			itemPartName = "item_pingguo",
			action = "restorePart"
		}
	},
	[6.66666666666667] = {
		{
			attachPoint = "gua_conghua",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_cong",
			action = "playEfx",
			entity = 1,
			duration = 0.5
		}
	},
	[8] = {
		{
			grabBy = 0,
			attachPoint = "gua_L_hand_bone",
			action = "grabPart",
			itemPartName = "item_pingguo",
			grabFrom = 1
		}
	},
	[12.7333333333333] = {
		{
			attachPoint = "gua_conghua",
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
