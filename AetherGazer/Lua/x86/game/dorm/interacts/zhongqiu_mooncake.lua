local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "01",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "mooncake_eat"
		},
		{
			animeActionSubName = "01",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "mooncake_eat"
		}
	},
	[1.86666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri_dayuebing",
			action = "playEfx",
			entity = 0,
			duration = 1
		}
	},
	[3.96666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri_dayuebing",
			action = "playEfx",
			entity = 0,
			duration = 0.7
		}
	},
	[6.8] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri_dayuebing_2",
			action = "playEfx",
			entity = 0,
			duration = 3
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1.86666666666667,
		3.96666666666667,
		6.8
	}
}

var_0_1.duration = 12.7
var_0_1.fps = 30

return var_0_1
