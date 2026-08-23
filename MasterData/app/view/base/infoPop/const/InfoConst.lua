local var_0_0 = {
	PAPER_TIP = 2,
	BASE_TIP = 1
}

return {
	BlitzType = {
		DUNGEON = 1,
		BIOGRAPHY = 2
	},
	UseBuyPopType = {
		USE = 0,
		BUY_USE = 1
	},
	InheritType = {
		TREASURE = 4,
		KNIGHT = 0,
		EQUIP = 3,
		PET = 2,
		ARTIFACT = 1
	},
	InfoTipPopType = var_0_0,
	InfoTipPopName = {
		[var_0_0.BASE_TIP] = "InfoFullTipPop",
		[var_0_0.PAPER_TIP] = "InfoPaperTipPop"
	},
	TabQuality = {
		[0] = 0,
		4,
		3,
		2,
		1
	},
	AUTO_TYPE = {
		BIO = 2,
		WUSH = 0,
		DUNGEON = 1
	}
}
