local var_0_0 = {
	sequence = {
		[0] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "barbecue_failed"
			},
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 1,
				animeActionName = "barbecue_failed"
			},
			{
				attachPoint = "gua_fx",
				efxPath = "QWWorld/Effect/fx_kaorou_backsmoke",
				action = "playEfx",
				entity = 1,
				duration = 0,
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
		[7.86666666666667] = {
			{
				attachPoint = "gua_fx",
				action = "clearEfx",
				entity = 0
			}
		}
	},
	keys = {
		0,
		7.86666666666667
	}
}

var_0_0.duration = 7.866667
var_0_0.fps = 30

return var_0_0
