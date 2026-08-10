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
			animeActionName = "tv_game_stand"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "tv_game_stand"
		},
		{
			attachPoint = "gua_bone005",
			efxPath = "Dorm/Effect/houzhai/fx_9148_youxigui_common",
			action = "playEfx",
			entity = 1,
			duration = 4.7,
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
			grabBy = 1,
			attachPoint = "gua_fx_disappear",
			action = "grabPart",
			itemPartName = "fx_9148_youxigui_pingmu",
			grabFrom = 1
		}
	},
	[0.7] = {
		{
			attachPoint = "gua_bone005",
			efxPath = "Dorm/Effect/houzhai/fx_9148_baozha1",
			action = "playEfx",
			entity = 1,
			duration = 0.1,
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
	[1.83333333333333] = {
		{
			attachPoint = "gua_bone005",
			efxPath = "Dorm/Effect/houzhai/fx_9148_baozha2",
			action = "playEfx",
			entity = 1,
			duration = 0.1,
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
	[2.4] = {
		{
			attachPoint = "gua_bone005",
			efxPath = "Dorm/Effect/houzhai/fx_9148_baozha3",
			action = "playEfx",
			entity = 1,
			duration = 0.1,
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
	[3.2] = {
		{
			attachPoint = "gua_bone005",
			efxPath = "Dorm/Effect/houzhai/fx_9148_baozha4",
			action = "playEfx",
			entity = 1,
			duration = 0.1,
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
	[3.9] = {
		{
			attachPoint = "gua_bone005",
			efxPath = "Dorm/Effect/houzhai/fx_9148_baozha5",
			action = "playEfx",
			entity = 1,
			duration = 0.1,
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
		0.7,
		1.83333333333333,
		2.4,
		3.2,
		3.9
	}
}

var_0_1.duration = 4.666667
var_0_1.fps = 30

return var_0_1
