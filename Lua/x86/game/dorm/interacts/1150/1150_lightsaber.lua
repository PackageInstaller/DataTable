local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "virtual_lightsaber"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "virtual_lightsaber"
		},
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		}
	},
	[1.16666666666667] = {
		{
			attachPoint = "gua_bone002",
			efxPath = "Dorm/Effect/houzhai/fx_9150_dao_1",
			action = "playEfx",
			entity = 1,
			duration = 7.4,
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
			attachPoint = "gua_bone003",
			efxPath = "Dorm/Effect/houzhai/fx_9150_dao_2",
			action = "playEfx",
			entity = 1,
			duration = 7.4,
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
			efxPath = "Dorm/Effect/houzhai/fx_9150_quanxi_zhuzi_switch",
			action = "playEfx",
			entity = 1,
			duration = 7,
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
			attachPoint = "gua_root",
			action = "grabPart",
			itemPartName = "fx_9150_quanxi_loop",
			grabFrom = 1
		}
	},
	[2.4] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9150_quanxi_zhuzi",
			action = "playEfx",
			entity = 1,
			duration = 4.72,
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
	[3.26666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9150_daoguang_1",
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
	[3.76666666666667] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9150_daoguang_2",
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
	[5.4] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9150_daoguang_3",
			action = "playEfx",
			entity = 1,
			duration = 0.8,
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
	[8.13333333333333] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/fx_9150_quanxi_zhuzi_chuxian",
			action = "playEfx",
			entity = 1,
			duration = 1.1,
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
	[9.26666666666667] = {
		{
			itemPartHost = 1,
			itemPartName = "fx_9150_quanxi_loop",
			action = "restorePart"
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1.16666666666667,
		2.4,
		3.26666666666667,
		3.76666666666667,
		5.4,
		8.13333333333333,
		9.26666666666667
	}
}

var_0_1.duration = 10.76667
var_0_1.fps = 30

return var_0_1
