local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "gongfu_story_read"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "gongfu_story_read"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[3.8] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9050_zhenjing",
			action = "playEfx",
			entity = 1,
			duration = 6,
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
		},
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_9050_lianhong",
			action = "playEfx",
			entity = 0,
			duration = 6,
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
		3.8
	}
}

var_0_1.duration = 17
var_0_1.fps = 30

return var_0_1
