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
			animeActionName = "watering_fruit"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "watering_fruit"
		}
	},
	[4.2] = {
		{
			attachPoint = "gua_shuihu",
			efxPath = "Dorm/Effect/houzhai/fx_9075_shuihua",
			action = "playEfx",
			entity = 1,
			duration = 1.6,
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
	[5.1] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9075_xinxin",
			action = "playEfx",
			entity = 1,
			duration = 3.01,
			offset = {
				z = 0.608,
				x = 0.559,
				y = -0.012
			},
			rotation = {
				w = 0.7071068,
				z = 0,
				x = 0.7071068,
				y = 0
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[5.83333333333333] = {
		{
			attachPoint = "gua_shuihu",
			efxPath = "Dorm/Effect/houzhai/fx_9075_shuihua",
			action = "playEfx",
			entity = 1,
			duration = 1.6,
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
	[6.8] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9075_xinxin1",
			action = "playEfx",
			entity = 1,
			duration = 3.01,
			offset = {
				z = 0,
				x = 0,
				y = 0
			},
			rotation = {
				w = 0.7071068,
				z = 0,
				x = 0.7071068,
				y = 0
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[9.16666666666667] = {
		{
			attachPoint = "gua_shuihu",
			efxPath = "Dorm/Effect/houzhai/fx_9075_shuihua",
			action = "playEfx",
			entity = 1,
			duration = 1.6,
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
	[9.86666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9075_xinxin",
			action = "playEfx",
			entity = 1,
			duration = 3.01,
			offset = {
				z = 0.557,
				x = -0.609,
				y = -0.072
			},
			rotation = {
				w = 0.7071068,
				z = 0,
				x = 0.7071068,
				y = 0
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[11.5] = {
		{
			attachPoint = "gua_shuihu",
			efxPath = "Dorm/Effect/houzhai/fx_9075_shuihua",
			action = "playEfx",
			entity = 1,
			duration = 1.6,
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
	[12.2666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9075_xinxin",
			action = "playEfx",
			entity = 1,
			duration = 1.6,
			offset = {
				z = 0.558,
				x = -0.142,
				y = -0.072
			},
			rotation = {
				w = 0.3535534,
				z = -0.6123725,
				x = 0.3535534,
				y = 0.6123725
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[25.8666666666667] = {
		{
			faceEfxPath = "Effect/Dorm/laugh02",
			duration = 1.1,
			action = "setSpFace",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		4.2,
		5.1,
		5.83333333333333,
		6.8,
		9.16666666666667,
		9.86666666666667,
		11.5,
		12.2666666666667,
		25.8666666666667
	}
}

var_0_1.duration = 32
var_0_1.fps = 30

return var_0_1
