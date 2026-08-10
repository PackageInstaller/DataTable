local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "rice_dumpling"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "rice_dumpling"
		},
		{
			referencePointName = "gua_start_sit",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[9.06666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_zhuanshu_guochangli",
			action = "playEfx",
			entity = 0,
			duration = 2
		}
	},
	[11] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_zhuanshu_guochangli_2",
			action = "playEfx",
			entity = 0,
			duration = 2
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		9.06666666666667,
		11
	}
}

var_0_1.duration = 21.16667
var_0_1.fps = 30

return var_0_1
