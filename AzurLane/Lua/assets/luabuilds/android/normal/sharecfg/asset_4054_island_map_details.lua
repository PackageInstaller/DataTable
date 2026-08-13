pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "island_map_details") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_map_details"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.island_map_details = var_0_2
pg = var_0

local var_0_3 = var_0.island_map_details

var_0_3.all = {
	100101,
	100102,
	100103,
	100201,
	100202,
	100203,
	100204,
	100205,
	100206,
	100301,
	100302,
	100401,
	100402,
	100501,
	100502,
	100601,
	100602,
	100603,
	100604
}
pg = var_0_3

local var_0_4 = var_0_3.island_map_details

var_0_4.get_id_list_by_belong_map = {
	[1001] = {
		100101,
		100102,
		100103
	},
	[1002] = {
		100201,
		100202,
		100203,
		100204,
		100205,
		100206
	},
	[1003] = {
		100301,
		100302
	},
	[1004] = {
		100401,
		100402
	},
	[1005] = {
		100501,
		100502
	},
	[1006] = {
		100601,
		100602,
		100603,
		100604
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.island_map_details = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_map_details

	var_1_0[5] = {
		belong_map = 1001,
		name = "丰壤农田",
		ability_id = 2001,
		production_place_id = 101,
		id = 100101,
		detail_icon = "101"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_map_details

	var_1_1[6] = {
		belong_map = 1001,
		name = "悠然牧场",
		ability_id = 2002,
		production_place_id = 102,
		id = 100102,
		detail_icon = "102"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_map_details

	var_1_2[7] = {
		belong_map = 1001,
		name = "风车磨坊",
		ability_id = 2002,
		production_place_id = 0,
		id = 100103,
		detail_icon = "103"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_map_details

	var_1_3[100201] = {
		belong_map = 1002,
		name = "JUU'物流",
		ability_id = 7,
		production_place_id = 0,
		id = 100201,
		detail_icon = "201"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_map_details

	var_1_4[100202] = {
		belong_map = 1002,
		name = "货运中心",
		ability_id = 32,
		production_place_id = 0,
		id = 100202,
		detail_icon = "202"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.island_map_details

	var_1_5[100203] = {
		belong_map = 1002,
		name = "啾咖啡",
		ability_id = 5009,
		production_place_id = 901,
		id = 100203,
		detail_icon = "203"
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.island_map_details

	var_1_6[100204] = {
		belong_map = 1002,
		name = "岛屿科技",
		ability_id = 5007,
		production_place_id = 702,
		id = 100204,
		detail_icon = "204"
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.island_map_details

	var_1_7[100205] = {
		belong_map = 1002,
		name = "基地工厂",
		ability_id = 2012,
		production_place_id = 0,
		id = 100205,
		detail_icon = "205"
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.island_map_details

	var_1_8[100206] = {
		belong_map = 1002,
		name = "啾啾渔场",
		ability_id = 2017,
		production_place_id = 201,
		id = 100206,
		detail_icon = "206"
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.island_map_details

	var_1_9[100301] = {
		belong_map = 1003,
		name = "自由搭建区",
		ability_id = 5003,
		production_place_id = 0,
		id = 100301,
		detail_icon = "301"
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.island_map_details

	var_1_10[100302] = {
		belong_map = 1003,
		name = "日常补给",
		ability_id = 5003,
		production_place_id = 0,
		id = 100302,
		detail_icon = "302"
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.island_map_details

	var_1_11[100401] = {
		belong_map = 1004,
		name = "沉石矿山",
		ability_id = 2003,
		production_place_id = 401,
		id = 100401,
		detail_icon = "401"
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.island_map_details

	var_1_12[100402] = {
		belong_map = 1004,
		name = "翠土林场 ",
		ability_id = 2004,
		production_place_id = 402,
		id = 100402,
		detail_icon = "402"
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.island_map_details

	var_1_13[21] = {
		belong_map = 1005,
		name = "坠香果园",
		ability_id = 2005,
		production_place_id = 501,
		id = 100501,
		detail_icon = "501"
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.island_map_details

	var_1_14[22] = {
		belong_map = 1005,
		name = "青芽苗圃",
		ability_id = 2006,
		production_place_id = 502,
		id = 100502,
		detail_icon = "502"
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.island_map_details

	var_1_15[100601] = {
		belong_map = 1006,
		name = "有鱼餐馆",
		ability_id = 2008,
		production_place_id = 601,
		id = 100601,
		detail_icon = "601"
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.island_map_details

	var_1_16[100602] = {
		belong_map = 1006,
		name = "白熊饮品",
		ability_id = 2009,
		production_place_id = 602,
		id = 100602,
		detail_icon = "602"
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.island_map_details

	var_1_17[100603] = {
		belong_map = 1006,
		name = "啾啾简餐",
		ability_id = 2010,
		production_place_id = 603,
		id = 100603,
		detail_icon = "603"
	}
	pg = var_1_17
	var_1_17.base.island_map_details[100604] = {
		belong_map = 1006,
		name = "乌鱼烤肉",
		ability_id = 2011,
		production_place_id = 604,
		id = 100604,
		detail_icon = "604"
	}

	return
end)()

return
