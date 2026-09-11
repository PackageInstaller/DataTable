local SummerChessBoardGameUIBaseData = class("SummerChessBoardGameUIBaseData")

function SummerChessBoardGameUIBaseData:Ctor(arg_1_1)
	self.activityID_ = arg_1_1
end

function SummerChessBoardGameUIBaseData:CurrentUnlockStageID()
	if ActivityTools.GetActivityStatus(self.activityID_) ~= ActivityConst.ACTIVITY_STATE.ACTIVING then
		return false, 0
	end

	local var_2_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[self.activityID_] or {}

	if #var_2_0 <= 0 then
		return true, 0
	end

	local var_2_1 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		var_2_1 = (ActivitySummerChessConditionCfg[iter_2_1].condition == 0 or IsConditionAchieved(ActivitySummerChessConditionCfg[iter_2_1].condition)) and iter_2_1
	end

	return var_2_1 ~= 0, var_2_1
end

function SummerChessBoardGameUIBaseData:GetUnlockConditionList()
	local var_3_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[self.activityID_] or {}
	local var_3_1 = {}

	if #var_3_0 <= 0 then
		return var_3_1
	end

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if ActivitySummerChessConditionCfg[iter_3_1].condition ~= 0 and IsConditionAchieved(ActivitySummerChessConditionCfg[iter_3_1].condition) then
			table.insert(var_3_1, iter_3_1)
		end
	end

	return var_3_1
end

function SummerChessBoardGameUIBaseData:GetUnlockTips()
	local var_4_0 = ActivityData:GetActivityData(self.activityID_)
	local var_4_1 = manager.time:GetServerTime()

	if var_4_1 < var_4_0.startTime then
		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStrWith2Unit(var_4_0.startTime, true)), 1
	elseif var_4_1 >= var_4_0.stopTime then
		return GetTips("TIME_OVER"), 1
	end

	local var_4_2 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[self.activityID_] or {}

	if #var_4_2 <= 0 then
		return "", 0
	end

	local var_4_3 = ActivitySummerChessConditionCfg[var_4_2[1]].condition

	if ActivitySummerChessConditionCfg[var_4_2[1]].condition == 0 then
		return "", 0
	end

	return string.format(GetTips("OPEN_TIME"), GetI18NText(ConditionCfg[var_4_3].desc)), 2
end

function SummerChessBoardGameUIBaseData:GotoGameWindow()
	print("TODO: 进入界面")
end

function SummerChessBoardGameUIBaseData:GetEntryRedPointKey()
	return string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_)
end

function SummerChessBoardGameUIBaseData:GetTaskIDList(arg_7_1)
	return TaskData2:GetTaskIDListByActivity(arg_7_1)
end

function SummerChessBoardGameUIBaseData:GetNeedReorderTask(arg_8_1)
	return true
end

function SummerChessBoardGameUIBaseData:GetTaskRedPointKey(arg_9_1)
	return string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_9_1)
end

return SummerChessBoardGameUIBaseData
