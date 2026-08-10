local var_0_0 = {
	[0.0666666666666667] = {
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "swing"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "swing"
		},
		{
			attachPoint = "gua_start",
			attachTo = 1,
			itemEntity = 0,
			action = "attachTo"
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9074_qiuqian",
			action = "playEfx",
			entity = 0,
			duration = 26,
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
	[3.93333333333333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Effect/Dorm/shy1",
			action = "playEfx",
			entity = 0,
			duration = 0.7,
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
	[4.633333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			action = "clearEfx",
			entity = 0
		}
	},
	[10.5333333333333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Effect/Dorm/shy03",
			action = "playEfx",
			entity = 0,
			duration = 1.7,
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
	[12.23333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			action = "clearEfx",
			entity = 0
		}
	},
	[13.4] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Effect/Dorm/shy02",
			action = "playEfx",
			entity = 0,
			duration = 2.4,
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
	[15.8] = {
		{
			attachPoint = "gua_biaoqing_bone",
			action = "clearEfx",
			entity = 0
		}
	},
	[19.6333333333333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Effect/Dorm/shy02",
			action = "playEfx",
			entity = 0,
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
	[26] = {
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
		0.0666666666666667,
		3.93333333333333,
		4.633333,
		10.5333333333333,
		12.23333,
		13.4,
		15.8,
		19.6333333333333,
		26
	}
}

var_0_1.duration = 26.46667
var_0_1.fps = 30

return var_0_1
