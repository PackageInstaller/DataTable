local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "01",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "lawson_vending_machine"
		},
		{
			animeActionSubName = "01",
			crossFade = 0.01,
			action = "play",
			entity = 1,
			animeActionName = "lawson_vending_machine"
		}
	},
	[4] = {
		{
			grabBy = 0,
			attachPoint = "gua_L_hand_bone",
			action = "grabPart",
			itemPartName = "item_fangkuai",
			grabFrom = 1
		}
	},
	[5.4] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_lawson_fanmaiji_1",
			action = "playEfx",
			entity = 0,
			duration = 2
		}
	},
	[8.3] = {
		{
			itemPartHost = 1,
			itemPartName = "item_fangkuai",
			action = "restorePart"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		4,
		5.4,
		8.3
	}
}

var_0_1.duration = 8.6
var_0_1.fps = 30

return var_0_1
