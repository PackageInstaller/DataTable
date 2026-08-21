local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "weaving_cloth"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "weaving_cloth"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[3.7] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/tongyong/fx_jingxia_0501",
			action = "playEfx",
			entity = 0,
			duration = 0.3,
			offset = {
				z = 0.78,
				x = 0.26,
				y = -0.21
			},
			rotation = {
				w = 0.3469374,
				z = 0.3862237,
				x = 0.8532087,
				y = 0.05000767
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[5] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_9011_jinghuang_1",
			action = "playEfx",
			entity = 0,
			duration = 1,
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
			efxPath = "Dorm/Effect/houzhai/fx_9011_jinghuang_1",
			action = "playEfx",
			entity = 0,
			duration = 1,
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
				x = -1,
				y = 1
			}
		}
	},
	[5.5] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_9011_youyu",
			action = "playEfx",
			entity = 0,
			duration = 3.6,
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
	[11.7] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Assets/ComSceneQ/ABResources/Dorm/Effect/tongyong/fx_canlan_0401",
			action = "playEfx",
			entity = 0,
			duration = 0.8,
			offset = {
				z = -0.15,
				x = 0,
				y = -0.12
			},
			rotation = {
				w = 1,
				z = 0,
				x = 0,
				y = 0
			},
			scale = {
				z = 0.8,
				x = 0.8,
				y = 0.8
			}
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		3.7,
		5,
		5.5,
		11.7
	}
}

var_0_1.duration = 15.8
var_0_1.fps = 30

return var_0_1
