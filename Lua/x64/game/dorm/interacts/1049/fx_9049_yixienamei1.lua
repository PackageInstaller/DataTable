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
			animeActionName = "longdi"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "longdi"
		},
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9049_shan",
			action = "playEfx",
			entity = 1,
			duration = 564,
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
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9049_shan1",
			action = "playEfx",
			entity = 1,
			duration = 564,
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
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9049_shan2",
			action = "playEfx",
			entity = 1,
			duration = 564,
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
	},
	[2.36666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9049_glow1",
			action = "playEfx",
			entity = 1,
			duration = 150,
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
	},
	[4.76666666666667] = {
		{
			attachPoint = "gua_01",
			efxPath = "Dorm/Effect/houzhai/sq_9049_yinfu",
			action = "playEfx",
			entity = 1,
			duration = 270,
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
	},
	[12] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9049_qi",
			action = "playEfx",
			entity = 1,
			duration = 150,
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
	},
	[20.7666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9049_smo",
			action = "playEfx",
			entity = 1,
			duration = 150,
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
		2.36666666666667,
		4.76666666666667,
		12,
		20.7666666666667
	}
}

var_0_1.duration = 22.66667
var_0_1.fps = 30

return var_0_1
