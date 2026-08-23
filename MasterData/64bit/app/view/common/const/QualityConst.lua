return {
	GOLD = 7,
	RED = 6,
	ORANGE = 5,
	PURPLE = 4,
	BLUE = 3,
	GREEN = 2,
	WHITE = 1,
	MAX_QUALITY = 5,
	MR = 5,
	UR = 4,
	SSR = 3,
	SR = 2,
	R = 1,
	NONE = 0,
	NEW_QUALITY_CTRL = {
		SUCCUBA = "OTHER",
		PRECIOUS = "ON",
		PET = "ON",
		UNITETOKEN = "ON",
		ARTIFACT = "ON",
		KNIGHT = "ON"
	},
	TabQuality = {
		ON = {
			[0] = {
				name = "ALL",
				quality = 0
			},
			{
				name = "MR",
				quality = 5
			},
			{
				name = "UR",
				quality = 4
			},
			{
				name = "SSR",
				quality = 3
			},
			{
				name = "SR",
				quality = 2
			},
			{
				name = "R",
				quality = 1
			}
		},
		OFF = {
			[0] = {
				name = "ALL",
				quality = 0
			},
			{
				name = "UR",
				quality = 4
			},
			{
				name = "SSR",
				quality = 3
			},
			{
				name = "SR",
				quality = 2
			},
			{
				name = "R",
				quality = 1
			}
		},
		OTHER = {
			[0] = {
				name = "ALL",
				quality = 0
			},
			{
				name = "UR",
				quality = 4
			},
			{
				name = "MR",
				quality = 5
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
