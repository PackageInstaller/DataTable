local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "weight_lifting"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "weight_lifting"
		}
	},
	[13] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9024_ju",
			action = "playEfx",
			entity = 1,
			duration = 15,
			offset = {
				z = 0.357,
				x = 0.14,
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
	[15.9666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9024_lang",
			action = "playEfx",
			entity = 1,
			duration = 15,
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
	[16] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9024_men",
			action = "playEfx",
			entity = 1,
			duration = 15,
			offset = {
				z = 0,
				x = -0.728,
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
	[17.5333333333333] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9024_zhuan",
			action = "playEfx",
			entity = 1,
			duration = 10,
			offset = {
				z = 1.67,
				x = 0.157,
				y = 0.101
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
	[20.0333333333333] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9024_hudong",
			action = "playEfx",
			entity = 1,
			duration = 7,
			offset = {
				z = 0.4016,
				x = 0.2024,
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
	[25.7333333333333] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9024_men",
			action = "playEfx",
			entity = 1,
			duration = 3,
			offset = {
				z = 0,
				x = 0.328,
				y = 0.579
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
		13,
		15.9666666666667,
		16,
		17.5333333333333,
		20.0333333333333,
		25.7333333333333
	}
}

var_0_1.duration = 28.96667
var_0_1.fps = 30

return var_0_1
