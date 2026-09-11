local var_0_0 = {
	LevelType = {
		DAILY = 0,
		CHALLENGE = 1
	},
	ShowItmeType = {
		effect = 3,
		shelf = 1,
		good = 2
	},
	OrientationTips = {
		double = "SIM_BUSINESS_SHELF_TYPE03",
		single = "SIM_BUSINESS_SHELF_TYPE02",
		four = "SIM_BUSINESS_SHELF_TYPE04",
		none = "SIM_BUSINESS_SHELF_TYPE01"
	},
	GoodTypeDesc = {
		"SIM_BUSINESS_GOODS_TYPE01",
		"SIM_BUSINESS_GOODS_TYPE02",
		"SIM_BUSINESS_GOODS_TYPE03",
		"SIM_BUSINESS_GOODS_TYPE04"
	}
}

var_0_0.OrientationType = {
	[0] = var_0_0.OrientationTips.none,
	var_0_0.OrientationTips.single,
	var_0_0.OrientationTips.double,
	var_0_0.OrientationTips.four
}

return var_0_0
