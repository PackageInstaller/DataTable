local var_0_0 = {
	DESIGN_HEIGHT = 1080,
	DESIGN_WIDTH = 1920,
	GRAPHIC_CUSTOM_ID = 7,
	SETTING_TYPE = {
		BATTLE_MAIN = 2,
		SYSTEM = 1,
		BATTLE_OTHER = 3
	},
	SOUND_POP_TYPE = {
		LANGUAGE = 1,
		PACKAGE = 3,
		VOICE = 2
	},
	FPS_TARGET = {
		FPS_60 = 1,
		FPS_30 = 0,
		FPS_120 = 2,
		FPS_90_PC_ONLY = 3
	},
	COMBO_SKILL = {
		[0] = 1,
		5,
		2,
		3,
		4
	}
}

var_0_0.TARGET_FRAME_RATE = {
	[var_0_0.FPS_TARGET.FPS_30] = 30,
	[var_0_0.FPS_TARGET.FPS_60] = 60,
	[var_0_0.FPS_TARGET.FPS_120] = 120,
	[var_0_0.FPS_TARGET.FPS_90_PC_ONLY] = 90
}

return var_0_0
