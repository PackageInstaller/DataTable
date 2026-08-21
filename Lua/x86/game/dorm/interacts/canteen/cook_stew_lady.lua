local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "01",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "stew"
		}
	},
	[1.03333333333333] = {
		{
			grabBy = 0,
			attachPoint = "gua_L_hand_bone",
			action = "grabPart",
			itemPartName = "item_guogai",
			grabFrom = 1
		}
	},
	[1.76666666666667] = {
		{
			attachPoint = "gua_smoke",
			efxPath = "Dorm/Effect/houzhai/fx_HZ04_TGsmoke",
			action = "playEfx",
			entity = 1,
			duration = 10.8
		}
	},
	[3.8] = {
		{
			grabBy = 0,
			attachPoint = "gua_R_hand_bone",
			action = "grabPart",
			itemPartName = "item_shaozi",
			grabFrom = 1
		}
	},
	[10.9] = {
		{
			itemPartHost = 1,
			itemPartName = "item_shaozi",
			action = "restorePart"
		}
	},
	[12.7333333333333] = {
		{
			itemPartHost = 1,
			itemPartName = "item_guogai",
			action = "restorePart"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1.03333333333333,
		1.76666666666667,
		3.8,
		10.9,
		12.7333333333333
	}
}

var_0_1.duration = 14.56667
var_0_1.fps = 30

return var_0_1
