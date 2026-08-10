local var_0_0 = {
	[0] = {
		{
			attachPoint = "gua_bone02",
			efxPath = "Dorm/Effect/houzhai/fx_jibanjianceyi",
			action = "playEfx",
			entity = 1,
			duration = 18.2,
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
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "tester"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "tester"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[5.36666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9048_daxiao",
			action = "playEfx",
			entity = 0,
			duration = 10,
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
	[8.16666666666667] = {
		{
			attachPoint = "gua_bone03",
			efxPath = "Dorm/Effect/houzhai/fx_jibanjianceyi_dou_r",
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
			attachPoint = "gua_bone04",
			efxPath = "Dorm/Effect/houzhai/fx_jibanjianceyi_dou_l",
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
		}
	},
	[9.83333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9048_shengqi",
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
	[12.1666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9048_wuyu",
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
		5.36666666666667,
		8.16666666666667,
		9.83333333333333,
		12.1666666666667
	}
}

var_0_1.duration = 17.8
var_0_1.fps = 30

return var_0_1
