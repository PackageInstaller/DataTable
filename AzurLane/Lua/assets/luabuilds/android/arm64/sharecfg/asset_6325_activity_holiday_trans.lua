pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "activity_holiday_trans") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "activity_holiday_trans"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.activity_holiday_trans = var_0_2
pg = var_0

local var_0_3 = var_0.activity_holiday_trans

var_0_3.all = {
	1,
	2,
	3,
	4
}
pg = var_0_3

local var_0_4 = var_0_3.activity_holiday_trans

var_0_4.get_id_list_by_type = {
	{
		1,
		2,
		3
	},
	{
		4
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
var_0_4.base.activity_holiday_trans = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.activity_holiday_trans

	var_1_0[1] = {
		cost_task_id = 23727,
		name = "小型运输船队",
		type = 1,
		id = 1,
		icon = "HolidayIcon/trans_1",
		result_ani = "",
		result_desc = "灵活机动的小批量运输专家，堪称性价比之王。\n完成了小型运输，获得木材X200，石材X200",
		award = {
			{
				8,
				66001,
				200
			},
			{
				8,
				66002,
				200
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.activity_holiday_trans

	var_1_1[2] = {
		cost_task_id = 23728,
		name = "中型运输船队",
		type = 1,
		id = 2,
		icon = "HolidayIcon/trans_2",
		result_ani = "",
		result_desc = "规模与效率的平衡之选，绝不将就的务实派。\n完成了中型运输，获得钢材*800",
		award = {
			{
				8,
				66003,
				800
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.activity_holiday_trans

	var_1_2[3] = {
		cost_task_id = 23729,
		name = "大型运输船队",
		type = 1,
		id = 3,
		icon = "HolidayIcon/trans_3",
		result_ani = "",
		result_desc = "大就是好，有钱就是任性，重建工作的可靠保障。\n完成了大型运输，获得电子零件*1200",
		award = {
			{
				8,
				66004,
				1200
			}
		}
	}
	pg = var_1_2
	var_1_2.base.activity_holiday_trans[4] = {
		cost_task_id = 23730,
		name = "邮轮观光船队",
		type = 2,
		id = 4,
		icon = "HolidayIcon/trans_4",
		result_ani = "",
		result_desc = "奢华与探险的完美结合，海上旅程的梦幻体验。\n完成邮轮观光，获得重建币*1000",
		award = {
			{
				8,
				66005,
				1000
			}
		}
	}

	return
end)()

return
