local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "wish"
		},
		{
			referencePointName = "gua_start_sit",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			grabBy = 0,
			attachPoint = "gua_L_hand_bone",
			action = "grabPart",
			itemPartName = "item_huima",
			grabFrom = 1
		},
		{
			grabBy = 0,
			attachPoint = "gua_R_hand_bone",
			action = "grabPart",
			itemPartName = "item_maobi",
			grabFrom = 1
		}
	},
	[4.06666666666667] = {
		{
			attachPoint = "HZ05_zhuanshu_yuedu",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_zhuanshu_yuedu_1",
			action = "playEfx",
			entity = 1,
			duration = 2
		}
	},
	[6.83333333333333] = {
		{
			attachPoint = "HZ05_zhuanshu_yuedu",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_zhuanshu_yuedu_2",
			action = "playEfx",
			entity = 1,
			duration = 2
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		4.06666666666667,
		6.83333333333333
	}
}

var_0_1.duration = 17.33333
var_0_1.fps = 30

return var_0_1
