pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "island_storage_filter_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_storage_filter_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.island_storage_filter_template = var_0_2
pg = var_0

local var_0_3 = var_0.island_storage_filter_template

var_0_3.all = {
	101,
	1011,
	10111,
	10112,
	10113,
	10114,
	1012,
	10121,
	10122,
	10123,
	10124,
	10125,
	10132,
	10133,
	10126,
	10127,
	10128,
	10129,
	10130,
	10131,
	10140,
	102,
	1021,
	10211,
	10212,
	10213,
	103,
	1031,
	10311,
	10312,
	10313,
	1010,
	104
}
pg = var_0_3

local var_0_4 = var_0_3.island_storage_filter_template

var_0_4.get_id_list_by_belong_filter_id = {
	[0] = {
		101,
		102,
		103,
		1010
	},
	[101] = {
		1011,
		1012
	},
	[102] = {
		1021
	},
	[103] = {
		1031
	},
	[1010] = {
		104
	},
	[1011] = {
		10111,
		10112,
		10113,
		10114
	},
	[1012] = {
		10121,
		10122,
		10123,
		10124,
		10125,
		10132,
		10133,
		10126,
		10127,
		10128,
		10129,
		10130,
		10131,
		10140
	},
	[1021] = {
		10211,
		10212,
		10213
	},
	[1031] = {
		10311,
		10312,
		10313
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
var_0_4.base.island_storage_filter_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_storage_filter_template

	var_1_0[101] = {
		belong_filter_id = 0,
		filter_level = 1,
		args = "",
		name = "资材",
		id = 101,
		res = "",
		sort_id = 1010
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_storage_filter_template

	var_1_1[1011] = {
		belong_filter_id = 101,
		filter_level = 2,
		args = "",
		name = "分类",
		id = 1011,
		res = "",
		sort_id = 0
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_storage_filter_template

	var_1_2[10111] = {
		belong_filter_id = 1011,
		filter_level = 3,
		args = "",
		name = "基础资材",
		id = 10111,
		res = "",
		sort_id = 0
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_storage_filter_template

	var_1_3[10112] = {
		belong_filter_id = 1011,
		filter_level = 3,
		args = "",
		name = "加工品",
		id = 10112,
		res = "",
		sort_id = 0
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_storage_filter_template

	var_1_4[10113] = {
		belong_filter_id = 1011,
		filter_level = 3,
		args = "",
		name = "产品",
		id = 10113,
		res = "",
		sort_id = 0
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.island_storage_filter_template

	var_1_5[10114] = {
		belong_filter_id = 1011,
		filter_level = 3,
		args = "",
		name = "其他",
		id = 10114,
		res = "",
		sort_id = 0
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.island_storage_filter_template

	var_1_6[1012] = {
		belong_filter_id = 101,
		filter_level = 2,
		args = "",
		name = "产地",
		id = 1012,
		res = "",
		sort_id = 0
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.island_storage_filter_template

	var_1_7[10121] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "丰壤农田",
		id = 10121,
		res = "",
		sort_id = 0
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.island_storage_filter_template

	var_1_8[10122] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "悠然牧场",
		id = 10122,
		res = "",
		sort_id = 0
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.island_storage_filter_template

	var_1_9[10123] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "沉石矿山",
		id = 10123,
		res = "",
		sort_id = 0
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.island_storage_filter_template

	var_1_10[10124] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "翠土林场 ",
		id = 10124,
		res = "",
		sort_id = 0
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.island_storage_filter_template

	var_1_11[10125] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "坠香果园",
		id = 10125,
		res = "",
		sort_id = 0
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.island_storage_filter_template

	var_1_12[10132] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "青芽苗圃",
		id = 10132,
		res = "",
		sort_id = 0
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.island_storage_filter_template

	var_1_13[10133] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "啾啾渔场",
		id = 10133,
		res = "",
		sort_id = 0
	}
	pg = var_1_13

	local var_1_14 = var_1_13.base.island_storage_filter_template

	var_1_14[10126] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "啾咖啡",
		id = 10126,
		res = "",
		sort_id = 0
	}
	pg = var_1_14

	local var_1_15 = var_1_14.base.island_storage_filter_template

	var_1_15[10127] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "有鱼餐馆",
		id = 10127,
		res = "",
		sort_id = 0
	}
	pg = var_1_15

	local var_1_16 = var_1_15.base.island_storage_filter_template

	var_1_16[10128] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "白熊饮品",
		id = 10128,
		res = "",
		sort_id = 0
	}
	pg = var_1_16

	local var_1_17 = var_1_16.base.island_storage_filter_template

	var_1_17[10129] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "啾啾简餐",
		id = 10129,
		res = "",
		sort_id = 0
	}
	pg = var_1_17

	local var_1_18 = var_1_17.base.island_storage_filter_template

	var_1_18[10130] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "乌鱼烤肉",
		id = 10130,
		res = "",
		sort_id = 0
	}
	pg = var_1_18

	local var_1_19 = var_1_18.base.island_storage_filter_template

	var_1_19[10131] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "基地工厂 ",
		id = 10131,
		res = "",
		sort_id = 0
	}
	pg = var_1_19

	local var_1_20 = var_1_19.base.island_storage_filter_template

	var_1_20[10140] = {
		belong_filter_id = 1012,
		filter_level = 3,
		args = "",
		name = "其他",
		id = 10140,
		res = "",
		sort_id = 0
	}
	pg = var_1_20

	local var_1_21 = var_1_20.base.island_storage_filter_template

	var_1_21[102] = {
		belong_filter_id = 0,
		filter_level = 1,
		args = "",
		name = "消耗品",
		id = 102,
		res = "",
		sort_id = 1010
	}
	pg = var_1_21

	local var_1_22 = var_1_21.base.island_storage_filter_template

	var_1_22[1021] = {
		belong_filter_id = 102,
		filter_level = 2,
		args = "",
		name = "分类",
		id = 1021,
		res = "",
		sort_id = 0
	}
	pg = var_1_22

	local var_1_23 = var_1_22.base.island_storage_filter_template

	var_1_23[10211] = {
		belong_filter_id = 1021,
		filter_level = 3,
		args = "",
		name = "角色养成",
		id = 10211,
		res = "",
		sort_id = 0
	}
	pg = var_1_23

	local var_1_24 = var_1_23.base.island_storage_filter_template

	var_1_24[10212] = {
		belong_filter_id = 1021,
		filter_level = 3,
		args = "",
		name = "增益特饮",
		id = 10212,
		res = "",
		sort_id = 0
	}
	pg = var_1_24

	local var_1_25 = var_1_24.base.island_storage_filter_template

	var_1_25[10213] = {
		belong_filter_id = 1021,
		filter_level = 3,
		args = "",
		name = "其他",
		id = 10213,
		res = "",
		sort_id = 0
	}
	pg = var_1_25

	local var_1_26 = var_1_25.base.island_storage_filter_template

	var_1_26[103] = {
		belong_filter_id = 0,
		filter_level = 1,
		args = "",
		name = "特殊",
		id = 103,
		res = "",
		sort_id = 1010
	}
	pg = var_1_26

	local var_1_27 = var_1_26.base.island_storage_filter_template

	var_1_27[1031] = {
		belong_filter_id = 103,
		filter_level = 2,
		args = "",
		name = "分类",
		id = 1031,
		res = "",
		sort_id = 0
	}
	pg = var_1_27

	local var_1_28 = var_1_27.base.island_storage_filter_template

	var_1_28[10311] = {
		belong_filter_id = 1031,
		filter_level = 3,
		args = "",
		name = "任务",
		id = 10311,
		res = "",
		sort_id = 0
	}
	pg = var_1_28

	local var_1_29 = var_1_28.base.island_storage_filter_template

	var_1_29[10312] = {
		belong_filter_id = 1031,
		filter_level = 3,
		args = "",
		name = "货币",
		id = 10312,
		res = "",
		sort_id = 0
	}
	pg = var_1_29

	local var_1_30 = var_1_29.base.island_storage_filter_template

	var_1_30[10313] = {
		belong_filter_id = 1031,
		filter_level = 3,
		args = "",
		name = "其他",
		id = 10313,
		res = "",
		sort_id = 0
	}
	pg = var_1_30

	local var_1_31 = var_1_30.base.island_storage_filter_template

	var_1_31[1010] = {
		belong_filter_id = 0,
		filter_level = 2,
		args = "",
		name = "排序",
		id = 1010,
		res = "",
		sort_id = 0
	}
	pg = var_1_31
	var_1_31.base.island_storage_filter_template[104] = {
		belong_filter_id = 1010,
		filter_level = 3,
		args = "GetRarity",
		name = "稀有度",
		id = 104,
		res = "",
		sort_id = 0
	}

	return
end)()

return
