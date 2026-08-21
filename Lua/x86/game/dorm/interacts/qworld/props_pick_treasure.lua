local var_0_0 = {
	[0] = {
		{
			attachPoint = "gua_start",
			efxPath = "QWWorld/Effect/fx_treasure_tip_dissipation",
			action = "playEfx",
			entity = 1,
			duration = 1,
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
	{
		{
			attachPoint = "gua_start",
			action = "clearEfx",
			entity = 1
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		1
	}
}

var_0_1.duration = 1
var_0_1.fps = 30

return var_0_1
