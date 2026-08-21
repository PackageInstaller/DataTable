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
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "ride_sheep"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "ride_sheep"
		},
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_9111_canlan",
			action = "playEfx",
			entity = 0,
			duration = 5,
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
	[0.9] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_9111_maopao",
			action = "playEfx",
			entity = 0,
			duration = 8.5,
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
	[8.6] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_9111_shuizhao",
			action = "playEfx",
			entity = 0,
			duration = 6.86,
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
	[13.5666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9111_shuaidao",
			action = "playEfx",
			entity = 0,
			duration = 5,
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
	[13.6333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9111_shengqi",
			action = "playEfx",
			entity = 0,
			duration = 5,
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
	[15.3666666666667] = {
		{
			attachPoint = "gua_bone009",
			efxPath = "Dorm/Effect/houzhai/fx_9111_lianxuquan",
			action = "playEfx",
			entity = 1,
			duration = 1.54,
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
	[16.8] = {
		{
			attachPoint = "gua_bone009",
			efxPath = "Dorm/Effect/houzhai/fx_9111_zhongquan",
			action = "playEfx",
			entity = 1,
			duration = 0.6,
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
	[21] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			attachPoint = "gua_biaoqing_bone",
			action = "clearEfx",
			entity = 0
		},
		{
			attachPoint = "gua_bone009",
			action = "clearEfx",
			entity = 1
		},
		{
			attachPoint = "root",
			action = "clearEfx",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		0.9,
		8.6,
		13.5666666666667,
		13.6333333333333,
		15.3666666666667,
		16.8,
		21
	}
}

var_0_1.duration = 21
var_0_1.fps = 30

return var_0_1
