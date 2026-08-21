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
			animeActionName = "jiaohu"
		},
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_xiahuo_liaoliguo_tang_bianse",
			action = "playEfx",
			entity = 1,
			duration = 23.8,
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
			attachPoint = "gua_hide",
			action = "grabPart",
			itemPartName = "sq_xiahuo_liaoliguo_tang_loop",
			grabFrom = 1
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "xiahuo1_liaoliguo"
		}
	},
	[12.2] = {
		{
			faceEfxPath = "QWWorld/Effect/FaceEffect/faint01",
			duration = 10.46667,
			action = "setSpFace",
			entity = 0
		}
	},
	[12.5] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/sq_xiahuo_liaoliguo_paomo",
			action = "playEfx",
			entity = 0,
			duration = 16.3,
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
	[13.63] = {
		{
			attachPoint = "gua_biaoqing_bone",
			efxPath = "Dorm/Effect/houzhai/sq_xiahuo_liaoliguo_yun",
			action = "playEfx",
			entity = 0,
			duration = 11.46667,
			offset = {
				z = -0.139,
				x = 0,
				y = -0.081
			},
			rotation = {
				w = 0.7071068,
				z = -0.7071068,
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
	[19.17] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_xiahuo_liaoliguo_smk",
			action = "playEfx",
			entity = 1,
			duration = 3.7,
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
	[23.8] = {
		{
			grabBy = 1,
			attachPoint = "gua_root",
			action = "grabPart",
			itemPartName = "sq_xiahuo_liaoliguo_tang_loop",
			grabFrom = 1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		12.2,
		12.5,
		13.63,
		19.17,
		23.8
	}
}

var_0_1.duration = 28.8
var_0_1.fps = 30

return var_0_1
