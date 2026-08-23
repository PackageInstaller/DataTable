local var_0_0 = {
	BASE_TIP = 1,
	PAPER_TIP = 2
}

return {
	BlitzType = {
		DUNGEON = 1,
		BIOGRAPHY = 2
	},
	UseBuyPopType = {
		BUY_USE = 1,
		USE = 0
	},
	InheritType = {
		KNIGHT = 0,
		TREASURE = 4,
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
		WUSH = 0,
		BIO = 2,
		DUNGEON = 1
	}
}
