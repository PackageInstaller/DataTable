local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.005,
			action = "play",
			entity = 1,
			animeActionName = "stand"
		},
		{
			animeActionSubName = "",
			crossFade = 0.005,
			action = "play",
			entity = 0,
			animeActionName = "zongziboat_stand"
		}
	},
	[2] = {
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 0,
			animeActionName = "zongziboat_idle"
		},
		{
			animeActionSubName = "",
			crossFade = 0.01,
			action = "play",
			entity = 1,
			animeActionName = "idle"
		}
	},
	[2.5] = {
		{
			grabBy = 0,
			attachPoint = "gua_L_hand_bone",
			action = "grabPart",
			itemPartName = "item_chuangjiang_B",
			grabFrom = 1
		}
	},
	[4.43333333333333] = {
		{
			grabBy = 0,
			attachPoint = "gua_R_hand_bone",
			action = "grabPart",
			itemPartName = "item_chuangjiang_A",
			grabFrom = 1
		}
	},
	[5.53333333333333] = {
		{
			attachPoint = "gua_fx",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_zongziboat_feng1",
			action = "playEfx",
			entity = 1,
			duration = 0.633
		}
	},
	[7.33333333333333] = {
		{
			attachPoint = "gua_fx",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_zongziboat_feng2",
			action = "playEfx",
			entity = 1,
			duration = 0.667
		}
	},
	[9.5] = {
		{
			attachPoint = "gua_fx",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_zongziboat_feng2",
			action = "playEfx",
			entity = 1,
			duration = 0.667
		}
	},
	[13] = {
		{
			itemPartHost = 1,
			itemPartName = "item_chuangjiang_B",
			action = "restorePart"
		}
	},
	[13.2] = {
		{
			itemPartHost = 1,
			itemPartName = "item_chuangjiang_A",
			action = "restorePart"
		}
	},
	[13.9333333333333] = {
		{
			scheme = "zongzi_boat",
			action = "changeScheme",
			entity = 0
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		2,
		2.5,
		4.43333333333333,
		5.53333333333333,
		7.33333333333333,
		9.5,
		13,
		13.2,
		13.9333333333333
	}
}

var_0_1.duration = 14.16667
var_0_1.fps = 30

return var_0_1
