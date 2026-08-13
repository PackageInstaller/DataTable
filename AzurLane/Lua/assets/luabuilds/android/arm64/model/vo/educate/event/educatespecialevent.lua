class = var_0_10000

local var_0_0 = "EducateSpecialEvent"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE_PLAN = 1
var_0_1.TYPE_SITE = 2
var_0_1.TYPE_BUBBLE_MIND = 3
var_0_1.TYPE_BUBBLE_DISCOUNT = 4
var_0_1.TAG_ING = 1
var_0_1.TAG_COMING = 2
var_0_1.TAG_END = 3
var_0_1.TAG2NAME = {
	[var_0_1.TAG_ING] = "ING",
	[var_0_1.TAG_COMING] = "COMING",
	[var_0_1.TAG_END] = "END"
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id

	arg_1_0:initTime()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_event_special
end

function var_0_1.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_1.IsPlanType(arg_4_0)
	return arg_4_0:GetType() == var_0_1.TYPE_PLAN
end

function var_0_1.GetGridIndexs(arg_5_0)
	local var_5_0 = {}

	for iter_5_0 = arg_5_0.startTime.day, arg_5_0.endTime.day do
		for iter_5_1 = arg_5_0:getConfig("date")[1][4], arg_5_0:getConfig("date")[2][4] do
			table = var_10

			var_10.insert(var_5_0, {
				iter_5_0,
				iter_5_1
			})
		end
	end

	return var_5_0
end

function var_0_1.IsSiteType(arg_6_0)
	return arg_6_0:GetType() == var_0_1.TYPE_SITE
end

function var_0_1.IsMatchSite(arg_7_0, arg_7_1)
	table = var_1_10002

	return var_1_10002.contains(arg_7_0:getConfig("type_param"), arg_7_1)
end

function var_0_1.initTime(arg_8_0)
	local var_8_0 = arg_8_0:getConfig("date")

	EducateHelper = var_1_10002
	arg_8_0.startTime, arg_8_0.endTime = var_1_10002.CfgTime2Time(var_8_0)

	return
end

function var_0_1.InTime(arg_9_0, arg_9_1)
	EducateHelper = var_1_10002

	return var_1_10002.InTime(arg_9_1, arg_9_0.startTime, arg_9_0.endTime)
end

function var_0_1.IsMatch(arg_10_0, arg_10_1)
	if arg_10_0:getConfig("child_attr2") == 0 then
		return true
	end

	return arg_10_0:getConfig("child_attr2") == arg_10_1
end

function var_0_1.IsUnlockSite(arg_11_0)
	if not arg_11_0:IsSiteType() then
		return true
	end

	EducateHelper = var_1

	local var_11_0 = var_1.IsSiteUnlock
	local var_11_1 = arg_11_0:getConfig("type_param")[1]

	getProxy = var_1_10004
	EducateProxy = var_6

	local var_11_2 = var_1_10004(var_6)

	return var_11_0(var_11_1, var_4.IsFirstGame(var_11_2))
end

function var_0_1.InNextWeekTime(arg_12_0, arg_12_1)
	EducateHelper = var_1_10002

	return var_1_10002.GetTimeAfterDays(arg_12_1, 7).month >= arg_12_0.startTime.month and var_2.month <= arg_12_0.endTime.month and var_2.week >= arg_12_0.startTime.week and var_2.week <= arg_12_0.endTime.week
end

function var_0_1.GetPerformance(arg_13_0)
	return arg_13_0:getConfig("performance")
end

function var_0_1.GetResult(arg_14_0)
	local var_14_0

	if not arg_14_0:getConfig("result_display") then
		var_14_0 = {}
	end

	return var_14_0
end

function var_0_1.InMonth(arg_15_0, arg_15_1)
	return arg_15_1 <= arg_15_0.startTime.month and arg_15_1 >= arg_15_0.endTime.month
end

function var_0_1.IsShow(arg_16_0)
	return arg_16_0:getConfig("show") ~= 0
end

function var_0_1.IsImport(arg_17_0)
	return arg_17_0:getConfig("show") == 1
end

function var_0_1.IsOther(arg_18_0)
	return arg_18_0:getConfig("show") == 2
end

function var_0_1.GetTag(arg_19_0, arg_19_1, arg_19_2)
	table = var_1_10003

	if var_1_10003.contains(arg_19_1, arg_19_0.id) or arg_19_2 > arg_19_0.endTime.week then
		return var_0_1.TAG_END
	else
		local var_19_0

		if not (arg_19_2 >= arg_19_0.startTime.week) or not var_0_1.TAG_ING then
			var_19_0 = var_0_1.TAG_COMING
		end

		return var_19_0
	end

	return
end

function var_0_1.GetTimeDesc(arg_20_0)
	if arg_20_0.startTime.week == arg_20_0.endTime.week then
		i18n = var_1

		return var_1("word_which_week", arg_20_0.startTime.week)
	else
		i18n = var_1

		local var_20_0 = var_1("word_which_week", arg_20_0.startTime.week)

		i18n = var_2

		local var_20_1 = var_2("word_which_week", arg_20_0.endTime.week)

		return var_20_0 .. "-" .. var_20_1
	end

	return
end

function var_0_1.GetDiscountShopId(arg_21_0)
	local var_21_0

	if arg_21_0:getConfig("type") == var_0_1.TYPE_BUBBLE_DISCOUNT then
		var_21_0 = arg_21_0:getConfig("type_param")[1]
		pg = var_2

		return var_2.child_site_option[var_21_0].param[1]
	end

	assert = var_21_0

	var_21_0(nil, "not discount type:" .. arg_21_0.id)

	return
end

function var_0_1.GetDiscountRatio(arg_22_0)
	if arg_22_0:getConfig("type") == var_0_1.TYPE_BUBBLE_DISCOUNT then
		return arg_22_0:getConfig("type_param")[2]
	end

	assert = var_1

	var_1(nil, "not discount type:" .. arg_22_0.id)

	return
end

function var_0_1.InDiscountTime(arg_23_0, arg_23_1)
	local var_23_1

	if arg_23_0:getConfig("type") == var_0_1.TYPE_BUBBLE_DISCOUNT then
		local var_23_0 = arg_23_0

		var_23_1 = arg_23_0.getConfig(var_23_0, "type_param")[3]
		EducateHelper = var_3

		local var_23_2 = var_3.GetTimeAfterWeeks(arg_23_1, var_23_1)

		EducateHelper = var_23_0

		return var_23_0.InTime(arg_23_1, arg_23_0.startTime, var_23_2)
	end

	assert = var_23_1

	var_23_1(nil, "not discount type:" .. arg_23_0.id)

	return
end

return var_0_1
