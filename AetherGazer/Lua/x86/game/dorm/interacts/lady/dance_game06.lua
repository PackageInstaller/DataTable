local var_0_0 = {
	[0] = {
		{
			referencePointName = "gua_start",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "06",
			crossFade = 0,
			action = "play",
			entity = 0,
			animeActionName = "dance_game"
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/tongyong/fx_tongyong_tiaowuji_on",
			action = "playEfx",
			entity = 1,
			duration = 10,
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
			itemPartName = "fx_tongyong_tiaowuji_off",
			grabFrom = 1
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
