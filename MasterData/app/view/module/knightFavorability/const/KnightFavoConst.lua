local var_0_0 = {
	DOSSIER = 2,
	FAVO_NUM = 1,
	STORY = 3,
	SOUND = 4
}

return {
	PLAY_LINES_TIME = 3,
	cfg = {
		FAVO_AVG_LENTH = 5
	},
	SOUND_STATUS = {
		PLAYING = 3,
		CAN_NOT_PLAY = 1,
		NULL_STATUS = 0,
		CAN_PLAY = 2
	},
	AWARD_STATUS = {
		HAVE_GOT = 3,
		CAN_GET = 2,
		NULL_STATUS = 0,
		CAN_NOT_GET = 1
	},
	OPTIONAL_BOX = {
		{
			id = 20223,
			isLike = true,
			addExp = 20219
		},
		{
			id = 20224,
			addExp = 20220
		},
		{
			id = 20225,
			addExp = 20221
		},
		{
			id = 20226,
			addExp = 20222
		}
	},
	TAB_TYPE = var_0_0,
	PANEL_PATH = {
		[var_0_0.FAVO_NUM] = "FavoComp",
		[var_0_0.DOSSIER] = "FavoDossierComp",
		[var_0_0.STORY] = "FavoStoryComp",
		[var_0_0.SOUND] = "FavoSoundComp"
	}
}
