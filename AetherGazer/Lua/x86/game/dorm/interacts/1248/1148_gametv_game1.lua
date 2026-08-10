local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "01",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "tv_game"
		},
		{
			animeActionSubName = "01",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "tv_game"
		},
		{
			attachPoint = "gua_bone005",
			efxPath = "Dorm/Effect/houzhai/fx_9148_boss_boom",
			action = "playEfx",
			entity = 1,
			duration = 0.4,
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
			attachPoint = "gua_bone005",
			efxPath = "Dorm/Effect/houzhai/fx_9148_youxigui_win",
			action = "playEfx",
			entity = 1,
			duration = 5.34,
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
	[0.933333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/tongyong/fx_daxiao_0801",
			action = "playEfx",
			entity = 0,
			duration = 1.14,
			offset = {
				z = -0.18,
				x = 0.379,
				y = 0.866
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
	[3.53333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/tongyong/fx_canlan_0401",
			action = "playEfx",
			entity = 0,
			duration = 1.17,
			offset = {
				z = -0.11,
				x = -0.01,
				y = 0.637
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
		0.933333333333333,
		3.53333333333333
	}
}

var_0_1.duration = 5.333333
var_0_1.fps = 30

return var_0_1
