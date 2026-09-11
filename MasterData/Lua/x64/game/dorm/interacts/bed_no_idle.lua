local var_0_0 = {
	sequence = {
		[0.1] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "bed_lie"
			},
			{
				referencePointName = "gua_start_bed",
				referenceTarget = 1,
				action = "putAt",
				entity = 0
			}
		},
		[6.26666666666667] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "bed_stand"
			},
			{
				scheme = "bed_no_idle",
				action = "changeScheme",
				entity = 0
			},
			{
				value = false,
				action = "setMobility",
				entity = 0
			}
		},
		[11.0333333333333] = {
			{
				value = false,
				action = "setMobility",
				entity = 0
			}
		}
	},
	keys = {
		0.1,
		6.26666666666667,
		11.0333333333333
	}
}

var_0_0.duration = 11.06667
var_0_0.fps = 30

return var_0_0
