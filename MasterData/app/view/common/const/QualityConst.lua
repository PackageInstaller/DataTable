return {
	SSR = 3,
	MR = 5,
	ORANGE = 5,
	GOLD = 7,
	UR = 4,
	GREEN = 2,
	SR = 2,
	WHITE = 1,
	RED = 6,
	PURPLE = 4,
	BLUE = 3,
	R = 1,
	MAX_QUALITY = 5,
	NONE = 0,
	NEW_QUALITY_CTRL = {
		PRECIOUS = "ON",
		KNIGHT = "ON",
		SUCCUBA = "OTHER",
		PET = "ON",
		UNITETOKEN = "ON",
		ARTIFACT = "ON"
	},
	TabQuality = {
		ON = {
			[0] = {
				quality = 0,
				name = "ALL"
			},
			{
				quality = 5,
				name = "MR"
			},
			{
				quality = 4,
				name = "UR"
			},
			{
				quality = 3,
				name = "SSR"
			},
			{
				quality = 2,
				name = "SR"
			},
			{
				quality = 1,
				name = "R"
			}
		},
		OFF = {
			[0] = {
				quality = 0,
				name = "ALL"
			},
			{
				quality = 4,
				name = "UR"
			},
			{
				quality = 3,
				name = "SSR"
			},
			{
				quality = 2,
				name = "SR"
			},
			{
				quality = 1,
				name = "R"
			}
		},
		OTHER = {
			[0] = {
				quality = 0,
				name = "ALL"
			},
			{
				quality = 4,
				name = "UR"
			},
			{
				quality = 5,
				name = "MR"
			}
		}
	},
	SELL_POP_QUALITY_ARRAY = {
		ON = {
			5,
			4,
			3,
			2,
			1
		},
		OFF = {
			4,
			3,
			2,
			1
		}
	}
}
