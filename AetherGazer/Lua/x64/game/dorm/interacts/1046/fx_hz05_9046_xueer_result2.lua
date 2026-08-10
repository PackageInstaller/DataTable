local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "2",
			crossFade = 0,
			action = "play",
			entity = 0,
			animeActionName = "capybara_doll_"
		},
		{
			animeActionSubName = "2",
			crossFade = 0,
			action = "play",
			entity = 1,
			animeActionName = "capybara_doll_"
		}
	},
	[2.6] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9046_xing",
			action = "playEfx",
			entity = 1,
			duration = 47.5,
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
		2.6
	}
}

var_0_1.duration = 6.166667
var_0_1.fps = 30

return var_0_1
