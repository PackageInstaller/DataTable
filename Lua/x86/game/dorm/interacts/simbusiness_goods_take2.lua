local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "02",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "goods_take"
		},
		{
			animeActionSubName = "02",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "goods_take"
		},
		{
			attachPoint = "gua_L_hand",
			efxPath = "CharDorm/prop/huowu1",
			action = "playEfx",
			entity = 0,
			duration = 4.7,
			offset = {
				z = 0.055,
				x = -0.025,
				y = -0.076
			},
			rotation = {
				w = -0.4394566,
				z = -0.8958818,
				x = 0.01495614,
				y = 0.06363998
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
		0
	}
}

var_0_1.duration = 5
var_0_1.fps = 30

return var_0_1
