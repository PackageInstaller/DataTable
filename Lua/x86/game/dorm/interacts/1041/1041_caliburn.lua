local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "caliburn"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "caliburn"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[0.933333333333333] = {
		{
			attachPoint = "gua_bone001",
			efxPath = "Dorm/Effect/houzhai/fx_9041_caliburn_chixu_glo",
			action = "playEfx",
			entity = 1,
			duration = 6.23,
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
	[4.66666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/tongyong/fx_maohan_0301",
			action = "playEfx",
			entity = 0,
			duration = 1.14,
			offset = {
				z = -0.018,
				x = -0.04,
				y = 0.81
			},
			rotation = {
				w = 0.978128,
				z = 0.03821845,
				x = 0.1917775,
				y = 0.0708967
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/tongyong/fx_maohan_0301",
			action = "playEfx",
			entity = 0,
			duration = 1.14,
			offset = {
				z = 0.035,
				x = 0.04,
				y = 0.81
			},
			rotation = {
				w = 0.01254444,
				z = -0.1715566,
				x = -0.1022719,
				y = -0.9797711
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[5.5] = {
		{
			attachPoint = "gua_bone001",
			efxPath = "Dorm/Effect/houzhai/fx_9041_caliburn_baozha",
			action = "playEfx",
			entity = 1,
			duration = 0.6,
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
	[10.5] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9041_caliburn_shengguang",
			action = "playEfx",
			entity = 0,
			duration = 4.6,
			offset = {
				z = 0,
				x = 0,
				y = 0
			},
			rotation = {
				w = -0.5,
				z = -0.5,
				x = 0.5,
				y = -0.5
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[14.4333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/tongyong/fx_jingxia_0501",
			action = "playEfx",
			entity = 0,
			duration = 2,
			offset = {
				z = -0.19,
				x = -0.34,
				y = 0.8
			},
			rotation = {
				w = -0.6245264,
				z = -0.3316123,
				x = 0.3316123,
				y = -0.6245264
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[15.3666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/tongyong/fx_wenhao_01",
			action = "playEfx",
			entity = 0,
			duration = 2,
			offset = {
				z = -0.19,
				x = -0.27,
				y = 0.8
			},
			rotation = {
				w = -0.6245264,
				z = -0.3316123,
				x = 0.3316123,
				y = -0.6245264
			},
			scale = {
				z = 1,
				x = 1,
				y = 1
			}
		}
	},
	[17.6] = {
		{
			attachPoint = "gua_bone001",
			efxPath = "Dorm/Effect/houzhai/fx_9041_caliburn_chajian",
			action = "playEfx",
			entity = 1,
			duration = 0.6,
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
	[18.2] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_9041_tanqi3",
			action = "playEfx",
			entity = 0,
			duration = 0,
			offset = {
				z = 0.56,
				x = -0.09,
				y = -0.01
			},
			rotation = {
				w = 0.5478868,
				z = 0.5411679,
				x = 0.4434319,
				y = 0.4586126
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
		4.66666666666667,
		5.5,
		10.5,
		14.4333333333333,
		15.3666666666667,
		17.6,
		18.2
	}
}

var_0_1.duration = 20.66667
var_0_1.fps = 30

return var_0_1
