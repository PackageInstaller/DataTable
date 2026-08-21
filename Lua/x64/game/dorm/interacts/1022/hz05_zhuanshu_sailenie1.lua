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
			entity = 1,
			animeActionName = "changpianji"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "changpianji"
		}
	},
	[5.6] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_hz05_9022_changpianji",
			action = "playEfx",
			entity = 1,
			duration = 4,
			offset = {
				z = 0,
				x = 0,
				y = 0
			},
			rotation = {
				w = -0.5,
				z = 0.5,
				x = -0.5,
				y = 0.5
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[9.6] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_hz05_9022_changpianji_1",
			action = "playEfx",
			entity = 1,
			duration = 7.8,
			offset = {
				z = 0,
				x = 0,
				y = 0
			},
			rotation = {
				w = -0.5,
				z = 0.5,
				x = -0.5,
				y = 0.5
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
		5.6,
		9.6
	}
}

var_0_1.duration = 17.4
var_0_1.fps = 30

return var_0_1
