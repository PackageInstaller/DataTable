pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "activity_drop_type") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "activity_drop_type"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.activity_drop_type = var_0_2
pg = var_0

local var_0_3 = var_0.activity_drop_type

var_0_3.all = {
	1001,
	1002,
	1003,
	1004,
	1005,
	1006
}
pg = var_0_3

local var_0_4 = var_0_3.activity_drop_type

var_0_4.get_id_list_by_activity_id = {
	[4852] = {
		1002
	},
	[4966] = {
		1003
	},
	[5523] = {
		1004
	},
	[5951] = {
		1005
	},
	[50043] = {
		1001
	},
	[2] = {
		1006
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
var_0_4.base.activity_drop_type = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.activity_drop_type

	var_1_0[1001] = {
		id = 1001,
		activity_id = 50043,
		relevance = ""
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.activity_drop_type

	var_1_1[1002] = {
		id = 1002,
		activity_id = 4852,
		relevance = "activity_workbench_item"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.activity_drop_type

	var_1_2[1003] = {
		id = 1003,
		activity_id = 4966,
		relevance = "activity_workbench_item"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.activity_drop_type

	var_1_3[1004] = {
		id = 1004,
		activity_id = 5523,
		relevance = ""
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.activity_drop_type

	var_1_4[1005] = {
		id = 1005,
		activity_id = 5951,
		relevance = ""
	}
	pg = var_1_4
	var_1_4.base.activity_drop_type[1006] = {
		id = 1006,
		activity_id = 50434,
		relevance = ""
	}

	return
end)()

return
