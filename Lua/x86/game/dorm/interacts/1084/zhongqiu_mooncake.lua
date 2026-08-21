local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "02",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "mooncake_eat"
		},
		{
			animeActionSubName = "02",
			crossFade = 0.05,
			action = "play",
			entity = 1,
			animeActionName = "mooncake_eat"
		}
	},
	[1.16666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri_dayuebing",
			action = "playEfx",
			entity = 0,
			duration = 0.5
		}
	},
	[2.06666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri_dayuebing",
			action = "playEfx",
			entity = 0,
			duration = 0.5
		}
	},
	[4.2] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_jieri_dayuebing",
			action = "playEfx",
			entity = 0,
			duration = 1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1.16666666666667,
		2.06666666666667,
		4.2
	}
}

var_0_1.duration = 10.73333
var_0_1.fps = 30

return var_0_1
