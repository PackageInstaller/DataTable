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
			animeActionName = "yindu1_feibing"
		},
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "jiaohu"
		}
	},
	[4.63] = {
		{
			attachPoint = "gua_01",
			efxPath = "Dorm/Effect/houzhai/sq_HZ05_yindu1_zhuozi1",
			action = "playEfx",
			entity = 1,
			duration = 87,
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
	[7.13] = {
		{
			attachPoint = "gua_01",
			efxPath = "Dorm/Effect/houzhai/sq_HZ05_yindu1_zhuozi2",
			action = "playEfx",
			entity = 1,
			duration = 52,
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
	[10.4] = {
		{
			attachPoint = "gua_root",
			efxPath = "Dorm/Effect/houzhai/sq_HZ05_yindu1_zhuozi3",
			action = "playEfx",
			entity = 1,
			duration = 98,
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
			efxPath = "Dorm/Effect/houzhai/sq_HZ05_yindu1_zhuozi4",
			action = "playEfx",
			entity = 1,
			duration = 38,
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
		4.63,
		7.13,
		10.4
	}
}

var_0_1.duration = 13.66667
var_0_1.fps = 30

return var_0_1
