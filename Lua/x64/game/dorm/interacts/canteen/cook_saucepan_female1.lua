local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "01",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "saucepan"
		}
	},
	[0.833333333333333] = {
		{
			grabBy = 0,
			attachPoint = "gua_R_hand_bone",
			action = "grabPart",
			itemPartName = "item_pingguo",
			grabFrom = 1
		}
	},
	[1.03333333333333] = {
		{
			attachPoint = "gua_chaocai",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_chaocai",
			action = "playEfx",
			entity = 1,
			duration = 8.95
		}
	},
	[9.96666666666667] = {
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
		0.833333333333333,
		1.03333333333333,
		9.96666666666667
	}
}

var_0_1.duration = 11.63333
var_0_1.fps = 30

return var_0_1
