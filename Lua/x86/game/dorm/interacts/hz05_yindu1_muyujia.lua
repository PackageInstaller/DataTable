local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "yindu1_muyujia"
		},
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_HZ05_yindu1_muyujia",
			action = "playEfx",
			entity = 1,
			duration = 864,
			offset = {
				z = 0,
				x = 0,
				y = 0
			},
			rotation = {
				w = 1,
				z = 0,
				x = 0,
				y = 0
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0
	}
}

var_0_1.duration = 13.33333
var_0_1.fps = 30

return var_0_1
