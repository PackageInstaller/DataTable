local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "01",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "wheelchair_trick"
		},
		{
			animeActionSubName = "01",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "wheelchair_trick"
		}
	},
	[3.23333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_shengdanlunyi_zhuan_root",
			action = "playEfx",
			entity = 1,
			duration = 4.2,
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
	[4.36666666666667] = {
		{
			faceEfxPath = "Effect/Dorm/sad01",
			duration = 3.2,
			action = "setSpFace",
			entity = 0
		}
	},
	[7.56666666666667] = {
		{
			faceEfxPath = "Effect/Dorm/faint01",
			duration = 4.5,
			action = "setSpFace",
			entity = 0
		}
	},
	[7.6] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_shengdanlunyi_zhuan_head",
			action = "playEfx",
			entity = 0,
			duration = 4.4,
			offset = {
				z = -0.09940813,
				x = 0,
				y = -0.08774196
			},
			rotation = {
				w = 0.4770452,
				z = -0.5219463,
				x = 0.5219463,
				y = -0.4770452
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[12.0666666666667] = {
		{
			faceEfxPath = "Effect/Dorm/sad01",
			duration = 1.833333,
			action = "setSpFace",
			entity = 0
		}
	},
	[12.1] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_shengdanlunyi_youling",
			action = "playEfx",
			entity = 0,
			duration = 1.833333,
			offset = {
				z = -0.09940813,
				x = 0,
				y = -0.08774196
			},
			rotation = {
				w = 0.4770452,
				z = -0.5219463,
				x = 0.5219463,
				y = -0.4770452
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
		3.23333333333333,
		4.36666666666667,
		7.56666666666667,
		7.6,
		12.0666666666667,
		12.1
	}
}

var_0_1.duration = 18.36667
var_0_1.fps = 30

return var_0_1
