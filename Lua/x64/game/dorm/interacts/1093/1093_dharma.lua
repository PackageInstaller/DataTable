local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "dharma_change"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "dharma_change"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			attachPoint = "root",
			efxPath = "CharDorm/prop/damohei",
			action = "playEfx",
			entity = 1,
			duration = 15,
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
	[1.9] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9093_smk",
			action = "playEfx",
			entity = 0,
			duration = 4,
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
	[15] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9093_smk",
			action = "playEfx",
			entity = 0,
			duration = 4,
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
		1.9,
		15
	}
}

var_0_1.duration = 18.6
var_0_1.fps = 30

return var_0_1
