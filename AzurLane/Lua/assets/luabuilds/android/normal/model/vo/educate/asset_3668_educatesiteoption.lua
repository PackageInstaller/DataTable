class = var_0_10000

local var_0_0 = "EducateSiteOption"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TYPE_SHOP = 1
var_0_1.TYPE_EVENT = 2
var_0_1.TYPE_SITE = 3

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.usedCnt = arg_1_2 or 0
	arg_1_0.remainCnt = arg_1_0:GetOriginalCnt() - arg_1_0.usedCnt
	getProxy = var_3
	EducateProxy = var_4

	local var_1_0 = var_3(var_4)

	arg_1_0.curTime = var_3.GetCurTime(var_1_0)

	arg_1_0:initTime()
	arg_1_0:initRefreshTime()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_site_option
end

function var_0_1.initTime(arg_3_0)
	if arg_3_0:IsLimitTime() then
		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.getConfig(var_3_0, "time_limit")

		EducateHelper = var_3_0
		arg_3_0.startTime, arg_3_0.endTime = var_3_0.CfgTime2Time(var_3_1)
	end

	return
end

function var_0_1.initRefreshTime(arg_4_0)
	if arg_4_0:IsEventType() and arg_4_0:IsCountLimit() then
		arg_4_0.refreshWeeks = {}

		local var_4_0 = 9
		local var_4_1 = 60
		local var_4_2 = arg_4_0
		local var_4_3 = arg_4_0.getConfig(var_4_2, "count_limit")[2]

		table = var_4_2

		var_4_2.insert(arg_4_0.refreshWeeks, var_4_0)

		while var_4_0 < var_4_1 do
			var_4_0 = var_4_0 + var_4_3
			table = var_4

			var_4.insert(arg_4_0.refreshWeeks, var_4_0)
		end
	end

	return
end

function var_0_1.IsShowLimit(arg_5_0)
	return arg_5_0:getConfig("is_limit") == 1 and arg_5_0.remainCnt > 0
end

function var_0_1.IsLimitTime(arg_6_0)
	return #arg_6_0:getConfig("time_limit") ~= 0
end

function var_0_1.IsCountLimit(arg_7_0)
	return arg_7_0:getConfig("count_limit") ~= "" and #arg_7_0:getConfig("count_limit") == 2
end

function var_0_1.IsShow(arg_8_0)
	if arg_8_0:IsLimitTime() then
		EducateHelper = var_1

		return var_1.InTime(arg_8_0.curTime, arg_8_0.startTime, arg_8_0.endTime)
	else
		return true
	end

	return
end

function var_0_1.GetType(arg_9_0)
	return arg_9_0:getConfig("type")
end

function var_0_1.IsEventType(arg_10_0)
	return arg_10_0:getConfig("type") == var_0_1.TYPE_EVENT
end

function var_0_1.IsReplace(arg_11_0)
	return arg_11_0:getConfig("replace") ~= 0
end

function var_0_1.GetCost(arg_12_0)
	return arg_12_0:getConfig("cost")
end

function var_0_1.GetLinkId(arg_13_0)
	return arg_13_0:getConfig("param")[1]
end

function var_0_1.GetOriginalCnt(arg_14_0)
	local var_14_0

	if not arg_14_0:IsCountLimit() or not arg_14_0:getConfig("count_limit")[1] then
		var_14_0 = 999
	end

	return var_14_0
end

function var_0_1.GetRemainCnt(arg_15_0)
	return arg_15_0.remainCnt
end

function var_0_1.GetCntText(arg_16_0)
	if not arg_16_0:IsCountLimit() then
		return ""
	end

	string = var_1

	return var_1.format("(%d/%d)", arg_16_0.remainCnt, arg_16_0:getConfig("count_limit")[1])
end

function var_0_1.CanTrigger(arg_17_0)
	return arg_17_0.remainCnt > 0
end

function var_0_1.ReduceCnt(arg_18_0)
	arg_18_0.remainCnt = arg_18_0.remainCnt - 1

	return
end

function var_0_1.IsShowPolaroid(arg_19_0)
	if #arg_19_0:getConfig("polarid_list") == 0 then
		return false
	end

	underscore = var_1

	return var_1.any(arg_19_0:getConfig("polarid_list"), function(arg_20_0)
		getProxy = var_2_10001
		EducateProxy = var_2_10002

		local var_20_0 = var_2_10001(var_2_10002)
		local var_20_2

		if not var_1.IsExistPolaroidByGroup(var_20_0, arg_20_0) then
			getProxy = var_1
			EducateProxy = var_20_0

			local var_20_1 = var_1(var_20_0)

			var_20_2 = var_1.CanGetPolaroidByGroup(var_20_1, arg_20_0)
		else
			var_20_2 = false
		end

		if false then
			var_20_2 = true
		end

		return var_20_2
	end)
end

function var_0_1.GetResults(arg_21_0)
	EducateHelper = var_1_10001

	if var_1_10001.IsShowNature() then
		return arg_21_0:getConfig("result_display")
	else
		underscore = var_1

		return var_1.select(arg_21_0:getConfig("result_display"), function(arg_22_0)
			local var_22_0 = arg_22_0[1]

			EducateConst = var_2_10002

			local var_22_3

			if var_22_0 == var_2_10002.DROP_TYPE_ATTR then
				getProxy = var_22_0
				EducateProxy = var_2

				local var_22_1 = var_22_0(var_2)
				local var_22_2 = var_1.GetCharData(var_22_1)

				var_22_3 = not var_1.IsPersonalityAttr(var_22_2, arg_22_0[2])

				if false then
					var_22_3 = false
				end
			else
				var_22_3 = true
			end

			return var_22_3
		end)
	end

	return
end

function var_0_1.IsResetWeek(arg_23_0, arg_23_1)
	table = var_1_10002

	return var_1_10002.contains(arg_23_0.refreshWeeks, arg_23_1)
end

function var_0_1.OnWeekUpdate(arg_24_0, arg_24_1)
	arg_24_0.curTime = arg_24_1

	arg_24_0:CheckCntReset()

	return
end

function var_0_1.CheckCntReset(arg_25_0)
	if arg_25_0:IsEventType() and arg_25_0:IsCountLimit() then
		EducateHelper = var_1

		local var_25_0 = var_1.GetWeekIdxWithTime(arg_25_0.curTime)

		if arg_25_0:IsResetWeek(var_25_0) then
			arg_25_0.remainCnt = arg_25_0:GetOriginalCnt()
		end
	end

	return
end

return var_0_1
