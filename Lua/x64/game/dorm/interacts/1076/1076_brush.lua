local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.003,
			action = "play",
			entity = 0,
			animeActionName = "brush_desk_idle"
		}
	},
	[4.9] = {
		{
			grabBy = 0,
			attachPoint = "gua_R_hand_bone",
			action = "grabPart",
			itemPartName = "item_maobi",
			grabFrom = 1
		}
	},
	[9.7] = {
		{
			attachPoint = "HZ05_xuheng1_diannaozhuo1",
			efxPath = "Dorm/Effect/houzhai/fx_9076_wenhaotanhao",
			action = "playEfx",
			entity = 1,
			duration = 2.4
		}
	},
	[12] = {
		{
			attachPoint = "HZ05_xuheng1_diannaozhuo1",
			action = "clearEfx",
			entity = 1
		}
	},
	[13.1666666666667] = {
		{
			attachPoint = "HZ05_xuheng1_diannaozhuo1",
			efxPath = "Dorm/Effect/houzhai/fx_9076_maobizi",
			action = "playEfx",
			entity = 1,
			duration = 12
		}
	},
	[22.2333333333333] = {
		{
			itemPartHost = 1,
			itemPartName = "item_maobi",
			action = "restorePart"
		}
	},
	[25.3666666666667] = {
		{
			attachPoint = "HZ05_xuheng1_diannaozhuo1",
			action = "clearEfx",
			entity = 1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		4.9,
		9.7,
		12,
		13.1666666666667,
		22.2333333333333,
		25.3666666666667
	}
}

var_0_1.duration = 25.9
var_0_1.fps = 30

return var_0_1
