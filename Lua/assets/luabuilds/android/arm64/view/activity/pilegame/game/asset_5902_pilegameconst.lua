local PileGameConst = class("PileGameConst")

PileGameConst.INDEX_WIDTH = 150
PileGameConst.SAFE_INDEX_WIDTH = 45
PileGameConst.DEATH_INDEX_WIDTH = 87
PileGameConst.ITEM_PIVOT = Vector2(0.5, 0)
PileGameConst.GROUND_SIZE = Vector2(1300, 20)
PileGameConst.GROUND_PIVOT = Vector2(0.5, 1)
PileGameConst.RATIO = 2
PileGameConst.START_Y = 150
PileGameConst.MAX_SLIDE_DISTANCE = PileGameConst.INDEX_WIDTH * PileGameConst.RATIO
PileGameConst.SAFE_LINE_DISTANCE = PileGameConst.SAFE_INDEX_WIDTH * PileGameConst.RATIO
PileGameConst.DEATH_LINE_DISTANCE = PileGameConst.DEATH_INDEX_WIDTH * PileGameConst.RATIO
PileGameConst.SLIDE_SPEED = 150
PileGameConst.SLIDE_GROWTH = {
	10,
	0.23
}
PileGameConst.DROP_SPEED = 600
PileGameConst.SINK_LEVEL = 4
PileGameConst.MAX_FAILED_CNT = 3
PileGameConst.LEVEL_TO_HAPPY_ANIM = 10
PileGameConst.SINK_TIME = 0.01
PileGameConst.SHAKE_DIS = 5
PileGameConst.SHAKE_SPEED = 10
PileGameConst.SHAKE_DIS_RATIO = 0.02
PileGameConst.PLAY_SPE_ACTION_TIME = 5
PileGameConst.BAN_OP_TIME = 1
PileGameConst.DEBUG = false
PileGameConst.Prefabs = {
	{
		name = "abercrombie_N",
		speActionCount = 1,
		boundary = {
			7.7,
			0,
			105,
			129.6
		},
		size = {
			157.82,
			139.22
		}
	},
	{
		name = "abercrombie_R",
		speActionCount = 0,
		boundary = {
			2.77,
			3.6,
			100,
			131.5
		},
		size = {
			156.9,
			138.8
		}
	},
	{
		name = "abercrombie_SR",
		speActionCount = 0,
		boundary = {
			2.7,
			3.6,
			100,
			131.5
		},
		size = {
			156.9,
			137.5
		}
	},
	{
		name = "abercrombie_SRR",
		speActionCount = 0,
		boundary = {
			2.7,
			3.6,
			100,
			131.5
		},
		size = {
			156.9,
			138.8
		}
	},
	{
		name = "abercrombie_SRR_1",
		speActionCount = 0,
		boundary = {
			2.7,
			3.6,
			100,
			131.5
		},
		size = {
			156.9,
			138.8
		}
	},
	{
		name = "abercrombie_SRR_2",
		speActionCount = 0,
		boundary = {
			2.7,
			3.6,
			100,
			131.5
		},
		size = {
			156.9,
			138.8
		}
	},
	{
		name = "abercrombie_UR",
		speActionCount = 0,
		boundary = {
			2.66,
			2.18,
			100,
			139.45
		},
		size = {
			160.9,
			143.8
		}
	},
	{
		name = "antenna",
		speActionCount = 1,
		boundary = {
			0,
			-0.49,
			120,
			85.37
		},
		size = {
			161.1,
			94.86
		}
	},
	{
		name = "enterprise",
		speActionCount = 1,
		boundary = {
			0,
			0,
			120,
			91.6
		},
		size = {
			159.2,
			101.48
		}
	},
	{
		name = "formidable",
		speActionCount = 2,
		boundary = {
			0,
			0,
			120,
			80.06
		},
		size = {
			168.98,
			88.96
		}
	},
	{
		name = "hammann",
		speActionCount = 1,
		boundary = {
			0,
			0,
			120,
			97.54
		},
		size = {
			151.45,
			97.54
		}
	},
	{
		name = "illustrious",
		speActionCount = 3,
		boundary = {
			0,
			0,
			110,
			96.02
		},
		size = {
			159.05,
			105.61
		}
	},
	{
		name = "justice",
		speActionCount = 2,
		boundary = {
			2.49,
			2.12,
			74,
			112.22
		},
		size = {
			163.87,
			116.46
		}
	},
	{
		name = "laffey",
		speActionCount = 2,
		boundary = {
			1,
			0.5,
			100,
			101
		},
		size = {
			168.86,
			110.03
		}
	},
	{
		name = "mutsuki",
		speActionCount = 2,
		boundary = {
			2.99,
			0,
			110,
			88.04
		},
		size = {
			152.91,
			96.5
		}
	},
	{
		name = "portland",
		speActionCount = 0,
		boundary = {
			0,
			-0.5,
			110,
			114.95
		},
		size = {
			164.55,
			124.3
		}
	},
	{
		name = "pound",
		speActionCount = 1,
		boundary = {
			2.99,
			0,
			96.02,
			84.06
		},
		size = {
			174.7,
			93.53
		}
	},
	{
		name = "shiratsuyu",
		speActionCount = 2,
		boundary = {
			0,
			2.6,
			120,
			87.9
		},
		size = {
			177.1,
			93.1
		}
	},
	{
		name = "soup",
		speActionCount = 2,
		boundary = {
			0,
			-2.5,
			110,
			89.8
		},
		size = {
			130.4,
			94.8
		}
	},
	{
		name = "unicorn",
		speActionCount = 1,
		boundary = {
			4,
			-2.5,
			110,
			87.6
		},
		size = {
			159.8,
			92.7
		}
	}
}
PileGameConst.HEAD = {
	name = "abercrombie_N",
	speActionCount = 0,
	boundary = {
		3.15,
		0,
		78.29,
		103
	},
	size = {
		125,
		113
	}
}

return PileGameConst
