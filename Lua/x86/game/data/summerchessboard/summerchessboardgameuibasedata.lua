local var_0_0 = class("SummerChessBoardGameUIBaseData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityID_ = arg_1_1
end

function var_0_0.CurrentUnlockStageID(arg_2_0)
	local var_2_0 = arg_2_0.activityID_

	if ActivityTools.GetActivityStatus(var_2_0) ~= ActivityConst.ACTIVITY_STATE.ACTIVING then
		return false, 0
	end

	local var_2_1 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_2_0] or {}

	if #var_2_1 <= 0 then
		return true, 0
	end

	local var_2_2 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_3 = ActivitySummerChessConditionCfg[iter_2_1].condition

		if var_2_3 == 0 or IsConditionAchieved(var_2_3) then
			var_2_2 = iter_2_1
		end
	end

	return var_2_2 ~= 0, var_2_2
end

function var_0_0.GetUnlockConditionList(arg_3_0)
	local var_3_0 = arg_3_0.activityID_
	local var_3_1 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_3_0] or {}
	local var_3_2 = {}

	if #var_3_1 <= 0 then
		return var_3_2
	end

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_3 = ActivitySummerChessConditionCfg[iter_3_1].condition

		if var_3_3 ~= 0 and IsConditionAchieved(var_3_3) then
			table.insert(var_3_2, iter_3_1)
		end
	end

	return var_3_2
end

function var_0_0.GetUnlockTips(arg_4_0)
	local var_4_0 = arg_4_0.activityID_
	local var_4_1 = ActivityData:GetActivityData(var_4_0)
	local var_4_2 = manager.time:GetServerTime()

	if var_4_2 < var_4_1.startTime then
		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStrWith2Unit(var_4_1.startTime, true)), 1
	elseif var_4_2 >= var_4_1.stopTime then
		return GetTips("TIME_OVER"), 1
	end

	local var_4_3 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_4_0] or {}

	if #var_4_3 <= 0 then
		return "", 0
	end

	local var_4_4 = var_4_3[1]
	local var_4_5 = ActivitySummerChessConditionCfg[var_4_4].condition

	if var_4_5 == 0 then
		return "", 0
	end

	return string.format(GetTips("OPEN_TIME"), GetI18NText(ConditionCfg[var_4_5].desc)), 2
end

function var_0_0.GotoGameWindow(arg_5_0)
	print("TODO: 进入界面")
end

function var_0_0.GetEntryRedPointKey(arg_6_0)
	local var_6_0 = arg_6_0.activityID_

	return string.format("%s%s", ActivityTools.GetRedPointKey(var_6_0), var_6_0)
end

function var_0_0.GetTaskIDList(arg_7_0, arg_7_1)
	return TaskData2:GetTaskIDListByActivity(arg_7_1)
end

function var_0_0.GetNeedReorderTask(arg_8_0, arg_8_1)
	return true
end

function var_0_0.GetTaskRedPointKey(arg_9_0, arg_9_1)
	return string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_9_1)
end

return var_0_0
