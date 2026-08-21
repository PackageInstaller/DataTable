local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.05,
			action = "play",
			entity = 0,
			animeActionName = "break_fail"
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_pizhuan_fail_1",
			action = "playEfx",
			entity = 0,
			duration = -1
		},
		{
			attachPoint = "gua_R_hand",
			efxPath = "Dorm/Effect/houzhai/fx_pizhuan_fail_2_Bip001_R_Hand",
			action = "playEfx",
			entity = 0,
			duration = -1
		},
		{
			action = "playVoice",
			awb = "",
			playerType = 2,
			sheet = "ui_dorm",
			cue = "ui_dorm_game_fail"
		}
	},
	[1.06666666666667] = function(arg_1_0)
		Dorm.DormEntityManager.ClearAllEffect(arg_1_0.entityID, "pizhuan_game")
	end
}
local var_0_1 = {
	sequence = var_0_0
}

var_0_1.duration = 7.6
var_0_1.fps = 30

return var_0_1
