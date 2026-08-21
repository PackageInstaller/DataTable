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
			entity = 1,
			animeActionName = "jiaohu_start"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "xiahuo1_baoxiang_start"
		},
		{
			attachPoint = "gua_coin",
			efxPath = "Dorm/Effect/houzhai/sq_xiahuo_baoxiang_bi",
			action = "playEfx",
			entity = 1,
			duration = 8.7,
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
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_xiahuo_baoxiang_shan",
			action = "playEfx",
			entity = 1,
			duration = 12.16667,
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
	[5.56666666666667] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/tongyong/fx_jingxia_0501",
			action = "playEfx",
			entity = 0,
			duration = 5,
			offset = {
				z = -0.332,
				x = -0.087,
				y = 0.131
			},
			rotation = {
				w = -0.6918164,
				z = -0.02579632,
				x = 0.5805348,
				y = -0.4286072
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[7.36666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_xiahuo_baoxiang_feng",
			action = "playEfx",
			entity = 1,
			duration = 4.8,
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
		5.56666666666667,
		7.36666666666667
	}
}

var_0_1.duration = 12.16667
var_0_1.fps = 30

return var_0_1
