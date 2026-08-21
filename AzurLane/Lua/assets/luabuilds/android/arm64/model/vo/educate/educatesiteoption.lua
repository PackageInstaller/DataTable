local var_0_0 = class("EducateSiteOption", import("model.vo.BaseVO"))

var_0_0.TYPE_SHOP = 1
var_0_0.TYPE_EVENT = 2
var_0_0.TYPE_SITE = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.usedCnt = arg_1_2 or 0
	arg_1_0.remainCnt = arg_1_0:GetOriginalCnt() - arg_1_0.usedCnt
	arg_1_0.curTime = getProxy(EducateProxy):GetCurTime()

	arg_1_0:initTime()
	arg_1_0:initRefreshTime()

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.child_site_option
end

function var_0_0.initTime(arg_3_0)
	if arg_3_0:IsLimitTime() then
		arg_3_0.startTime, arg_3_0.endTime = EducateHelper.CfgTime2Time((arg_3_0:getConfig("time_limit")))
	end

	return
end

function var_0_0.initRefreshTime(arg_4_0)
	if arg_4_0:IsEventType() and arg_4_0:IsCountLimit() then
		arg_4_0.refreshWeeks = {}

		local var_4_0 = 9
		local var_4_1 = arg_4_0:getConfig("count_limit")[2]

		table.insert(arg_4_0.refreshWeeks, 9)

		while var_4_0 < 60 do
			var_4_0 = var_4_0 + var_4_1

			table.insert(arg_4_0.refreshWeeks, var_4_0)
		end
	end

	return
end

function var_0_0.IsShowLimit(arg_5_0)
	return arg_5_0:getConfig("is_limit") == 1 and arg_5_0.remainCnt > 0
end

function var_0_0.IsLimitTime(arg_6_0)
	return #arg_6_0:getConfig("time_limit") ~= 0
end

function var_0_0.IsCountLimit(arg_7_0)
	return arg_7_0:getConfig("count_limit") ~= "" and #arg_7_0:getConfig("count_limit") == 2
end

function var_0_0.IsShow(arg_8_0)
	if arg_8_0:IsLimitTime() then
		return EducateHelper.InTime(arg_8_0.curTime, arg_8_0.startTime, arg_8_0.endTime)
	else
		return true
	end

	return
end

function var_0_0.GetType(arg_9_0)
	return arg_9_0:getConfig("type")
end

function var_0_0.IsEventType(arg_10_0)
	return arg_10_0:getConfig("type") == var_0_0.TYPE_EVENT
end

function var_0_0.IsReplace(arg_11_0)
	return arg_11_0:getConfig("replace") ~= 0
end

function var_0_0.GetCost(arg_12_0)
	return arg_12_0:getConfig("cost")
end

function var_0_0.GetLinkId(arg_13_0)
	return arg_13_0:getConfig("param")[1]
end

function var_0_0.GetOriginalCnt(arg_14_0)
	return arg_14_0:IsCountLimit() and arg_14_0:getConfig("count_limit")[1] or 999
end

function var_0_0.GetRemainCnt(arg_15_0)
	return arg_15_0.remainCnt
end

function var_0_0.GetCntText(arg_16_0)
	if not arg_16_0:IsCountLimit() then
		return ""
	end

	return string.format("(%d/%d)", arg_16_0.remainCnt, arg_16_0:getConfig("count_limit")[1])
end

function var_0_0.CanTrigger(arg_17_0)
	return arg_17_0.remainCnt > 0
end

function var_0_0.ReduceCnt(arg_18_0)
	arg_18_0.remainCnt = arg_18_0.remainCnt - 1

	return
end

function var_0_0.IsShowPolaroid(arg_19_0)
	if #arg_19_0:getConfig("polarid_list") == 0 then
		return false
	end

	return underscore.any(arg_19_0:getConfig("polarid_list"), function(arg_20_0)
		local var_20_0 = getProxy(EducateProxy)

		return not var_20_0:IsExistPolaroidByGroup(arg_20_0) and getProxy(EducateProxy):CanGetPolaroidByGroup(arg_20_0)
	end)
end

function var_0_0.GetResults(arg_21_0)
	if EducateHelper.IsShowNature() then
		return arg_21_0:getConfig("result_display")
	else
		return underscore.select(arg_21_0:getConfig("result_display"), function(arg_22_0)
			local var_22_0

			if arg_22_0[1] == EducateConst.DROP_TYPE_ATTR then
				var_22_0 = not getProxy(EducateProxy):GetCharData():IsPersonalityAttr(arg_22_0[2])

				if false then
					var_22_0 = false
				end
			else
				var_22_0 = true
			end

			return var_22_0
		end)
	end

	return
end

function var_0_0.IsResetWeek(arg_23_0, arg_23_1)
	return table.contains(arg_23_0.refreshWeeks, arg_23_1)
end

function var_0_0.OnWeekUpdate(arg_24_0, arg_24_1)
	arg_24_0.curTime = arg_24_1

	arg_24_0:CheckCntReset()

	return
end

function var_0_0.CheckCntReset(arg_25_0)
	if arg_25_0:IsEventType() and arg_25_0:IsCountLimit() and arg_25_0:IsResetWeek((EducateHelper.GetWeekIdxWithTime(arg_25_0.curTime))) then
		arg_25_0.remainCnt = arg_25_0:GetOriginalCnt()
	end

	return
end

return var_0_0
