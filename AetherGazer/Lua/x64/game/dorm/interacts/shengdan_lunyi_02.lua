local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "02",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "wheelchair_trick"
		},
		{
			animeActionSubName = "02",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "wheelchair_trick"
		}
	},
	[3.23333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_shengdanlunyi_qianhou_root",
			action = "playEfx",
			entity = 1,
			duration = 1.933333,
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
	[3.76666666666667] = {
		{
			attachPoint = "gua_lunyi",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_shengdanlunyi_qianhou_lunyi",
			action = "playEfx",
			entity = 1,
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
	[3.83333333333333] = {
		{
			faceEfxPath = "Effect/Dorm/sad01",
			duration = 3.7,
			action = "setSpFace",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		3.23333333333333,
		3.76666666666667,
		3.83333333333333
	}
}

var_0_1.duration = 13.66667
var_0_1.fps = 30

return var_0_1
