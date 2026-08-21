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
			animeActionName = "fangliaozhuo"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "fangliaozhuo"
		}
	},
	[7.1] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9095_yeti",
			action = "playEfx",
			entity = 1,
			duration = 9.166667,
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
	[7.2] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9095_smk",
			action = "playEfx",
			entity = 1,
			duration = 10.2,
			offset = {
				z = 0.372,
				x = -0.06400002,
				y = 0.03099996
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
		},
		{
			attachPoint = "gua_pingziA",
			efxPath = "Dorm/Effect/houzhai/sq_9095_pingzi",
			action = "playEfx",
			entity = 1,
			duration = 7.366667,
			offset = {
				z = -0.07864718,
				x = 0.3381126,
				y = 0.04005203
			},
			rotation = {
				w = -0.4959256,
				z = -0.5040413,
				x = 0.4959256,
				y = 0.5040413
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		},
		{
			grabBy = 1,
			attachPoint = "gua_hide",
			action = "grabPart",
			itemPartName = "sq_9095_pingzi_loop",
			grabFrom = 1
		}
	},
	[13.4] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_9095_boom",
			action = "playEfx",
			entity = 1,
			duration = 10,
			offset = {
				z = 0.4156,
				x = -0.079,
				y = 0.03549999
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
	[14.57] = {
		{
			grabBy = 1,
			attachPoint = "gua_pingzi",
			action = "grabPart",
			itemPartName = "sq_9095_pingzi_loop",
			grabFrom = 1
		}
	},
	[19.2] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/sq_9095_nanguo",
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
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		7.1,
		7.2,
		13.4,
		14.57,
		19.2
	}
}

var_0_1.duration = 24.33333
var_0_1.fps = 30

return var_0_1
