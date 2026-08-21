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
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "lawson_cashier"
		},
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 1,
			animeActionName = "lawson_cashier"
		}
	},
	[2.66666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_lawson_cashier_1",
			action = "playEfx",
			entity = 0,
			duration = 3
		}
	},
	[5.43333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_lawson_cashier_2",
			action = "playEfx",
			entity = 0,
			duration = 1.8
		}
	},
	[7.73333333333333] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_lawson_cashier_3",
			action = "playEfx",
			entity = 0,
			duration = 2
		}
	},
	[9.1] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_lawson_cashier_4",
			action = "playEfx",
			entity = 0,
			duration = 1.1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		2.66666666666667,
		5.43333333333333,
		7.73333333333333,
		9.1
	}
}

var_0_1.duration = 11.16667
var_0_1.fps = 30

return var_0_1
