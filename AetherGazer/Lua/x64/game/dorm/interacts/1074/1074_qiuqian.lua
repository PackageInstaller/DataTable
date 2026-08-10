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
			attachPoint = "gua_sit",
			attachTo = 1,
			itemEntity = 0,
			action = "attachTo"
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9074_qiuqian",
			action = "playEfx",
			entity = 0,
			duration = 26
		}
	},
	[3.93333333333333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Effect/Dorm/shy1",
			action = "playEfx",
			entity = 0,
			duration = 0.7
		}
	},
	[10.5333333333333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Effect/Dorm/shy03",
			action = "playEfx",
			entity = 0,
			duration = 1.7
		}
	},
	[13.4] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Effect/Dorm/shy02",
			action = "playEfx",
			entity = 0,
			duration = 2.4
		}
	},
	[19.6333333333333] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Effect/Dorm/shy02",
			action = "playEfx",
			entity = 0,
			duration = 1.6
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0.0666666666666667,
		3.93333333333333,
		10.5333333333333,
		13.4,
		19.6333333333333
	}
}

var_0_1.duration = 26.46667
var_0_1.fps = 30

return var_0_1
