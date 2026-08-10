local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "1",
			crossFade = 0,
			action = "play",
			entity = 0,
			animeActionName = "capybara_doll_"
		},
		{
			animeActionSubName = "1",
			crossFade = 0,
			action = "play",
			entity = 1,
			animeActionName = "capybara_doll_"
		}
	},
	[5.63333333333333] = {
		{
			attachPoint = "gua_head",
			efxPath = "Dorm/Effect/houzhai/sq_9046_xian",
			action = "playEfx",
			entity = 0,
			duration = 53,
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
		0,
		5.63333333333333
	}
}

var_0_1.duration = 9.5
var_0_1.fps = 30

return var_0_1
