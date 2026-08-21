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
			animeActionName = "present_bag_moving"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "present_bag_moving"
		}
	},
	[2.9] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_liwudai_root",
			action = "playEfx",
			entity = 1,
			duration = 17.3,
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
	[7.66666666666667] = {
		{
			attachPoint = "gua_liwudai",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri2_liwudai_Bone_Chain_3",
			action = "playEfx",
			entity = 1,
			duration = 8.833333,
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
		2.9,
		7.66666666666667
	}
}

var_0_1.duration = 21.83333
var_0_1.fps = 30

return var_0_1
