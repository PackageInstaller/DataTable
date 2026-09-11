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
				animeActionName = "lawson_icecream"
			},
			{
				animeActionSubName = "",
				crossFade = 0.01,
				action = "play",
				entity = 1,
				animeActionName = "lawson_icecream"
			}
		},
		[6] = {
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_lawson_icecream_suipian",
				action = "playEfx",
				entity = 0,
				duration = 1.5
			}
		}
	},
	keys = {
		0,
		6
	}
}

var_0_0.duration = 10.26667
var_0_0.fps = 30

return var_0_0
