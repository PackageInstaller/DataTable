pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "activity_single_enemy") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "activity_single_enemy"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.activity_single_enemy = var_0_2
pg = var_0

local var_0_3 = var_0.activity_single_enemy

var_0_3.all = {
	1001,
	1002,
	1003,
	1004,
	1005,
	2001,
	2002,
	2003,
	2004,
	2005,
	2006,
	2007,
	2008,
	2009,
	2010,
	2011,
	2012,
	2013,
	3001,
	3002,
	3003,
	4001,
	4002,
	4003,
	1000001,
	1000002,
	1000003,
	1000004,
	1000005
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.activity_single_enemy = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.activity_single_enemy

	var_1_0[1001] = {
		pre_chapter = 0,
		count = 0,
		type = 1,
		expedition_id = 0,
		activity_type = 1,
		name = "",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1001,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.activity_single_enemy

	var_1_1[1002] = {
		pre_chapter = 1001,
		count = 0,
		type = 2,
		expedition_id = 0,
		activity_type = 1,
		name = "",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1002,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.activity_single_enemy

	var_1_2[1003] = {
		pre_chapter = 1002,
		count = 0,
		type = 3,
		expedition_id = 0,
		activity_type = 1,
		name = "",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1003,
		use_oil_limit = {
			25,
			15
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.activity_single_enemy

	var_1_3[1004] = {
		pre_chapter = 1003,
		count = 1,
		type = 4,
		expedition_id = 0,
		activity_type = 1,
		name = "",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1004,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {
			{
				"level",
				1,
				110
			}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.activity_single_enemy

	var_1_4[1005] = {
		pre_chapter = 1003,
		count = 0,
		type = 5,
		expedition_id = 0,
		activity_type = 1,
		name = "",
		guardian_limit = 1,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1005,
		use_oil_limit = {
			40,
			16
		},
		limitation = {},
		property_limitation = {
			{
				"level",
				1,
				105
			}
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.activity_single_enemy

	var_1_5[2001] = {
		pre_chapter = 0,
		count = 0,
		type = 1,
		expedition_id = 1901001,
		activity_type = 2,
		name = "T1 住院大楼",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 2,
		icon = "clue_5",
		level = "LV.20",
		time = "always",
		enter_cost = 0,
		id = 2001,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905364
			},
			{
				2,
				905365
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201304,
			201309,
			201310,
			201311
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.activity_single_enemy

	var_1_6[2002] = {
		pre_chapter = 0,
		count = 0,
		type = 1,
		expedition_id = 1901002,
		activity_type = 2,
		name = "T2 疗养中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 2,
		icon = "clue_2",
		level = "LV.20",
		time = "always",
		enter_cost = 0,
		id = 2002,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905364
			},
			{
				2,
				905365
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201305,
			201309,
			201312
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.activity_single_enemy

	var_1_7[2003] = {
		pre_chapter = 0,
		count = 0,
		type = 1,
		expedition_id = 1901003,
		activity_type = 2,
		name = "T3 后勤中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 2,
		icon = "clue_1",
		level = "LV.20",
		time = "always",
		enter_cost = 0,
		id = 2003,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905364
			},
			{
				2,
				905365
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201306,
			201309,
			201313
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.activity_single_enemy

	var_1_8[2004] = {
		pre_chapter = 0,
		count = 0,
		type = 1,
		expedition_id = 1901004,
		activity_type = 2,
		name = "T4 研究中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 2,
		icon = "clue_3",
		level = "LV.20",
		time = "always",
		enter_cost = 0,
		id = 2004,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905364
			},
			{
				2,
				905365
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201307,
			201314,
			201315,
			201316,
			201317,
			201318
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.activity_single_enemy

	var_1_9[2005] = {
		pre_chapter = 0,
		count = 0,
		type = 2,
		expedition_id = 1902001,
		activity_type = 2,
		name = "T1 住院大楼",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 3,
		icon = "clue_5",
		level = "LV.50",
		time = "always",
		enter_cost = 0,
		id = 2005,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905367
			},
			{
				2,
				905368
			},
			{
				3,
				905369
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201304,
			201309,
			201310,
			201311
		}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.activity_single_enemy

	var_1_10[2006] = {
		pre_chapter = 0,
		count = 0,
		type = 2,
		expedition_id = 1902002,
		activity_type = 2,
		name = "T2 疗养中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 3,
		icon = "clue_2",
		level = "LV.50",
		time = "always",
		enter_cost = 0,
		id = 2006,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905367
			},
			{
				2,
				905368
			},
			{
				3,
				905369
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201305,
			201309,
			201312
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.activity_single_enemy

	var_1_11[2007] = {
		pre_chapter = 0,
		count = 0,
		type = 2,
		expedition_id = 1902003,
		activity_type = 2,
		name = "T3 后勤中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 3,
		icon = "clue_1",
		level = "LV.50",
		time = "always",
		enter_cost = 0,
		id = 2007,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905367
			},
			{
				2,
				905368
			},
			{
				3,
				905369
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201306,
			201309,
			201313
		}
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.activity_single_enemy

	var_1_12[2008] = {
		pre_chapter = 0,
		count = 0,
		type = 2,
		expedition_id = 1902004,
		activity_type = 2,
		name = "T4 研究中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 3,
		icon = "clue_3",
		level = "LV.50",
		time = "always",
		enter_cost = 0,
		id = 2008,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905367
			},
			{
				2,
				905368
			},
			{
				3,
				905369
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201307,
			201314,
			201315,
			201316,
			201317,
			201318
		}
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.activity_single_enemy

	var_1_13[2009] = {
		pre_chapter = 0,
		count = 0,
		type = 3,
		expedition_id = 1903001,
		activity_type = 2,
		name = "T1 住院大楼",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 4,
		icon = "clue_5",
		level = "LV.90",
		time = "always",
		enter_cost = 0,
		id = 2009,
		use_oil_limit = {
			25,
			15
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905371
			},
			{
				2,
				905372
			},
			{
				3,
				905373
			},
			{
				4,
				905374
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201304,
			201309,
			201310,
			201311
		}
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.activity_single_enemy

	var_1_14[2010] = {
		pre_chapter = 0,
		count = 0,
		type = 3,
		expedition_id = 1903002,
		activity_type = 2,
		name = "T2 疗养中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 4,
		icon = "clue_2",
		level = "LV.90",
		time = "always",
		enter_cost = 0,
		id = 2010,
		use_oil_limit = {
			25,
			15
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905371
			},
			{
				2,
				905372
			},
			{
				3,
				905373
			},
			{
				4,
				905374
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201305,
			201309,
			201312
		}
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.activity_single_enemy

	var_1_15[2011] = {
		pre_chapter = 0,
		count = 0,
		type = 3,
		expedition_id = 1903003,
		activity_type = 2,
		name = "T3 后勤中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 4,
		icon = "clue_1",
		level = "LV.90",
		time = "always",
		enter_cost = 0,
		id = 2011,
		use_oil_limit = {
			25,
			15
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905371
			},
			{
				2,
				905372
			},
			{
				3,
				905373
			},
			{
				4,
				905374
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201306,
			201309,
			201313
		}
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.activity_single_enemy

	var_1_16[2012] = {
		pre_chapter = 0,
		count = 0,
		type = 3,
		expedition_id = 1903004,
		activity_type = 2,
		name = "T4 研究中心",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_num = 4,
		icon = "clue_3",
		level = "LV.90",
		time = "always",
		enter_cost = 0,
		id = 2012,
		use_oil_limit = {
			25,
			15
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905371
			},
			{
				2,
				905372
			},
			{
				3,
				905373
			},
			{
				4,
				905374
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201307,
			201314,
			201315,
			201316,
			201317,
			201318
		}
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.activity_single_enemy

	var_1_17[2013] = {
		pre_chapter = 0,
		count = 0,
		type = 4,
		expedition_id = 1904001,
		activity_type = 2,
		name = "ESP 诊疗中心",
		guardian_limit = 0,
		enter_cost_drop = 905380,
		strategy_num = 4,
		icon = "clue_4",
		level = "LV.110",
		time = "always",
		enter_cost = 65561,
		id = 2013,
		use_oil_limit = {
			40,
			16
		},
		limitation = {},
		property_limitation = {},
		extra_drop = {
			{
				1,
				905376
			},
			{
				2,
				905377
			},
			{
				3,
				905378
			},
			{
				4,
				905379
			}
		},
		strategy_id = {
			201301,
			201302,
			201303,
			201308,
			201309,
			201319,
			201320
		}
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.activity_single_enemy

	var_1_18[3001] = {
		pre_chapter = 0,
		count = 0,
		type = 1,
		expedition_id = 1929001,
		activity_type = 1,
		name = "ABRS-1",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "30",
		time = "always",
		enter_cost = 0,
		extra_drop = "",
		id = 3001,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.activity_single_enemy

	var_1_19[3002] = {
		pre_chapter = 3001,
		count = 0,
		type = 1,
		expedition_id = 1929002,
		activity_type = 1,
		name = "ABRS-2",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "60",
		time = "always",
		enter_cost = 0,
		extra_drop = "",
		id = 3002,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.activity_single_enemy

	var_1_20[3003] = {
		pre_chapter = 3002,
		count = 0,
		type = 1,
		expedition_id = 1929003,
		activity_type = 1,
		name = "ABRS-3",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "90",
		time = "always",
		enter_cost = 0,
		extra_drop = "",
		id = 3003,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.activity_single_enemy

	var_1_21[4001] = {
		pre_chapter = 0,
		count = 0,
		type = 1,
		expedition_id = 2049001,
		activity_type = 1,
		name = "BATTLE-1",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "30",
		time = "always",
		enter_cost = 0,
		extra_drop = "",
		id = 4001,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.activity_single_enemy

	var_1_22[4002] = {
		pre_chapter = 4001,
		count = 0,
		type = 1,
		expedition_id = 2049002,
		activity_type = 1,
		name = "BATTLE-2",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "60",
		time = "always",
		enter_cost = 0,
		extra_drop = "",
		id = 4002,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.activity_single_enemy

	var_1_23[4003] = {
		pre_chapter = 4002,
		count = 0,
		type = 1,
		expedition_id = 2049003,
		activity_type = 1,
		name = "BATTLE-3",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "90",
		time = "always",
		enter_cost = 0,
		extra_drop = "",
		id = 4003,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.activity_single_enemy

	var_1_24[1000001] = {
		pre_chapter = 0,
		count = 0,
		type = 1,
		expedition_id = 1799001,
		activity_type = 1,
		name = "",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1000001,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.activity_single_enemy

	var_1_25[1000002] = {
		pre_chapter = 1000001,
		count = 0,
		type = 2,
		expedition_id = 1799002,
		activity_type = 1,
		name = "",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1000002,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.activity_single_enemy

	var_1_26[1000003] = {
		pre_chapter = 1000002,
		count = 0,
		type = 3,
		expedition_id = 1799003,
		activity_type = 1,
		name = "",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1000003,
		use_oil_limit = {
			25,
			15
		},
		limitation = {},
		property_limitation = {}
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.activity_single_enemy

	var_1_27[1000004] = {
		pre_chapter = 1000003,
		count = 1,
		type = 4,
		expedition_id = 1799004,
		activity_type = 1,
		name = "",
		guardian_limit = 0,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1000004,
		use_oil_limit = {
			0,
			0
		},
		limitation = {},
		property_limitation = {
			{
				"level",
				1,
				110
			}
		}
	}
	pg = var_1_27
	var_1_27.base.activity_single_enemy[1000005] = {
		pre_chapter = 1000003,
		count = 0,
		type = 5,
		expedition_id = 1799005,
		activity_type = 1,
		name = "",
		guardian_limit = 1,
		enter_cost_drop = 0,
		strategy_id = "",
		strategy_num = 0,
		icon = "",
		level = "",
		time = "stop",
		enter_cost = 0,
		extra_drop = "",
		id = 1000005,
		use_oil_limit = {
			40,
			16
		},
		limitation = {},
		property_limitation = {
			{
				"level",
				1,
				105
			}
		}
	}

	return
end)()

return
