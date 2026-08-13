pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "activity_skirmish_event") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "activity_skirmish_event"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.activity_skirmish_event = var_0_2
pg = var_0

local var_0_3 = var_0.activity_skirmish_event

var_0_3.all = {
	101,
	102,
	103,
	104,
	105,
	106,
	107
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.activity_skirmish_event = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.activity_skirmish_event

	var_1_0[101] = {
		id = 101,
		name = "P1-演习",
		type = 1,
		event = "1242017",
		task_id = 16500,
		award_display = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.activity_skirmish_event

	var_1_1[102] = {
		id = 102,
		name = "P2-护航",
		type = 2,
		event = "1250031",
		task_id = 16501,
		award_display = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.activity_skirmish_event

	var_1_2[103] = {
		id = 103,
		name = "P3-任务",
		type = 1,
		event = "FENGBAOQIANXI3",
		task_id = 16502,
		award_display = {}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.activity_skirmish_event

	var_1_3[104] = {
		id = 104,
		name = "P4-合流",
		type = 2,
		event = "1250032",
		task_id = 16503,
		award_display = {}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.activity_skirmish_event

	var_1_4[105] = {
		id = 105,
		name = "P5-扫荡",
		type = 2,
		event = "1250033",
		task_id = 16504,
		award_display = {}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.activity_skirmish_event

	var_1_5[106] = {
		id = 106,
		name = "P6-干扰",
		type = 1,
		event = "FENGBAOQIANXI7",
		task_id = 16505,
		award_display = {}
	}
	pg = var_1_5
	var_1_5.base.activity_skirmish_event[107] = {
		id = 107,
		name = "P7-联络",
		type = 2,
		event = "1250034",
		task_id = 16506,
		award_display = {}
	}

	return
end)()

return
