local var_0_0 = {
	sequence = {
		[0] = {
			{
				referencePointName = "gua_start",
				referenceTarget = 1,
				action = "putAt",
				entity = 0
			},
			{
				animeActionSubName = "",
				crossFade = 0.01,
				action = "play",
				entity = 0,
				animeActionName = "lawson_coffee"
			},
			{
				animeActionSubName = "",
				crossFade = 0.01,
				action = "play",
				entity = 1,
				animeActionName = "lawson_coffee"
			}
		},
		[7.8] = {
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_lawson_coffee_1",
				action = "playEfx",
				entity = 0,
				duration = 2
			}
		}
	},
	keys = {
		0,
		7.8
	}
}

var_0_0.duration = 18.76667
var_0_0.fps = 30

return var_0_0
