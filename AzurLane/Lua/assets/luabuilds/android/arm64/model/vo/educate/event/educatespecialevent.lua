local var_0_0 = class("EducateSpecialEvent", import("model.vo.BaseVO"))

var_0_0.TYPE_PLAN = 1
var_0_0.TYPE_SITE = 2
var_0_0.TYPE_BUBBLE_MIND = 3
var_0_0.TYPE_BUBBLE_DISCOUNT = 4
var_0_0.TAG_ING = 1
var_0_0.TAG_COMING = 2
var_0_0.TAG_END = 3
var_0_0.TAG2NAME = {
	[var_0_0.TAG_ING] = "ING",
	[var_0_0.TAG_COMING] = "COMING",
	[var_0_0.TAG_END] = "END"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id

	arg_1_0:initTime()

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.child_event_special
end

function var_0_0.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_0.IsPlanType(arg_4_0)
	return arg_4_0:GetType() == var_0_0.TYPE_PLAN
end

function var_0_0.GetGridIndexs(arg_5_0)
	for iter_5_0 = arg_5_0.startTime.day, arg_5_0.endTime.day do
		for iter_5_1 = arg_5_0:getConfig("date")[1][4], arg_5_0:getConfig("date")[2][4] do
			table.insert({}, {
				iter_5_0,
				iter_5_1
			})
		end
	end

	return {}
end

function var_0_0.IsSiteType(arg_6_0)
	return arg_6_0:GetType() == var_0_0.TYPE_SITE
end

function var_0_0.IsMatchSite(arg_7_0, arg_7_1)
	return table.contains(arg_7_0:getConfig("type_param"), arg_7_1)
end

function var_0_0.initTime(arg_8_0)
	arg_8_0.startTime, arg_8_0.endTime = EducateHelper.CfgTime2Time((arg_8_0:getConfig("date")))

	return
end

function var_0_0.InTime(arg_9_0, arg_9_1)
	return EducateHelper.InTime(arg_9_1, arg_9_0.startTime, arg_9_0.endTime)
end

function var_0_0.IsMatch(arg_10_0, arg_10_1)
	if arg_10_0:getConfig("child_attr2") == 0 then
		return true
	end

	return arg_10_0:getConfig("child_attr2") == arg_10_1
end

function var_0_0.IsUnlockSite(arg_11_0)
	if not arg_11_0:IsSiteType() then
		return true
	end

	return EducateHelper.IsSiteUnlock(arg_11_0:getConfig("type_param")[1], getProxy(EducateProxy):IsFirstGame())
end

function var_0_0.InNextWeekTime(arg_12_0, arg_12_1)
	local var_12_0 = EducateHelper.GetTimeAfterDays(arg_12_1, 7)

	return var_12_0.month >= arg_12_0.startTime.month and var_12_0.month <= arg_12_0.endTime.month and var_12_0.week >= arg_12_0.startTime.week and var_12_0.week <= arg_12_0.endTime.week
end

function var_0_0.GetPerformance(arg_13_0)
	return arg_13_0:getConfig("performance")
end

function var_0_0.GetResult(arg_14_0)
	return arg_14_0:getConfig("result_display") or {}
end

function var_0_0.InMonth(arg_15_0, arg_15_1)
	return arg_15_1 <= arg_15_0.startTime.month and arg_15_1 >= arg_15_0.endTime.month
end

function var_0_0.IsShow(arg_16_0)
	return arg_16_0:getConfig("show") ~= 0
end

function var_0_0.IsImport(arg_17_0)
	return arg_17_0:getConfig("show") == 1
end

function var_0_0.IsOther(arg_18_0)
	return arg_18_0:getConfig("show") == 2
end

function var_0_0.GetTag(arg_19_0, arg_19_1, arg_19_2)
	if table.contains(arg_19_1, arg_19_0.id) or arg_19_2 > arg_19_0.endTime.week then
		do return var_0_0.TAG_END end

		goto label_19_0
	end

	::label_19_0::

	if arg_19_2 >= arg_19_0.startTime.week then
		do
			return var_0_0.TAG_ING or var_0_0.TAG_COMING
		end

		return
	end
end

function var_0_0.GetTimeDesc(arg_20_0)
	if arg_20_0.startTime.week == arg_20_0.endTime.week then
		return i18n("word_which_week", arg_20_0.startTime.week)
	else
		return i18n("word_which_week", arg_20_0.startTime.week) .. "-" .. i18n("word_which_week", arg_20_0.endTime.week)
	end

	return
end

function var_0_0.GetDiscountShopId(arg_21_0)
	if arg_21_0:getConfig("type") == var_0_0.TYPE_BUBBLE_DISCOUNT then
		return pg.child_site_option[arg_21_0:getConfig("type_param")[1]].param[1]
	end

	assert(nil, "not discount type:" .. arg_21_0.id)

	return
end

function var_0_0.GetDiscountRatio(arg_22_0)
	if arg_22_0:getConfig("type") == var_0_0.TYPE_BUBBLE_DISCOUNT then
		return arg_22_0:getConfig("type_param")[2]
	end

	assert(nil, "not discount type:" .. arg_22_0.id)

	return
end

function var_0_0.InDiscountTime(arg_23_0, arg_23_1)
	if arg_23_0:getConfig("type") == var_0_0.TYPE_BUBBLE_DISCOUNT then
		return EducateHelper.InTime(arg_23_1, arg_23_0.startTime, (EducateHelper.GetTimeAfterWeeks(arg_23_1, arg_23_0:getConfig("type_param")[3])))
	end

	assert(nil, "not discount type:" .. arg_23_0.id)

	return
end

return var_0_0
