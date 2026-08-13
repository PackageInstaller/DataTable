pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "land_based_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "land_based_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.land_based_template = var_0_2
pg = var_0

local var_0_3 = var_0.land_based_template

var_0_3.all = {
	1,
	2,
	3,
	4,
	10,
	11,
	12,
	13,
	101,
	102,
	103
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.land_based_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.land_based_template

	var_1_0[1] = {
		name = "岸防炮",
		prefab = "anfangpao1",
		type = 1,
		id = 1,
		function_args = {
			-3,
			0
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.land_based_template

	var_1_1[2] = {
		name = "岸防炮",
		prefab = "anfangpao2",
		type = 1,
		id = 2,
		function_args = {
			3,
			0
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.land_based_template

	var_1_2[3] = {
		name = "岸防炮",
		prefab = "anfangpao3",
		type = 1,
		id = 3,
		function_args = {
			0,
			-3
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.land_based_template

	var_1_3[4] = {
		name = "岸防炮",
		prefab = "anfangpao4",
		type = 1,
		id = 4,
		function_args = {
			0,
			3
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.land_based_template

	var_1_4[10] = {
		name = "港口",
		prefab = "gangkou",
		type = 2,
		id = 10,
		function_args = {
			1
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.land_based_template

	var_1_5[11] = {
		name = "船坞",
		prefab = "chuanwu",
		type = 3,
		id = 11,
		function_args = {
			800,
			3
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.land_based_template

	var_1_6[12] = {
		name = "防空炮",
		prefab = "fangkongpao",
		type = 4,
		id = 12,
		function_args = {
			1,
			3
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.land_based_template

	var_1_7[13] = {
		name = "机场",
		prefab = "",
		type = 0,
		id = 13,
		function_args = ""
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.land_based_template

	var_1_8[101] = {
		name = "路基机场",
		prefab = "16zhangjichang1",
		type = 5,
		id = 101,
		function_args = {}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.land_based_template

	var_1_9[102] = {
		name = "路基机场",
		prefab = "16zhangjichang2",
		type = 5,
		id = 102,
		function_args = {}
	}
	pg = var_1_9
	var_1_9.base.land_based_template[103] = {
		name = "路基机场",
		prefab = "16zhangjichang3",
		type = 5,
		id = 103,
		function_args = {}
	}

	return
end)()

return
