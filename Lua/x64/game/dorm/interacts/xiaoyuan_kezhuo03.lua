local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "01",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "student_chair"
		},
		{
			referencePointName = "gua_start_sit",
			referenceTarget = 1,
			action = "putAt",
			entity = 0
		},
		{
			animeActionSubName = "01",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "student_chair"
		}
	},
	[7.26666666666667] = {
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_HZ05_xiaoyuan1_kezhuo1_2",
			action = "playEfx",
			entity = 0,
			duration = 2
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0,
		7.26666666666667
	}
}

var_0_1.duration = 16
var_0_1.fps = 30

return var_0_1
