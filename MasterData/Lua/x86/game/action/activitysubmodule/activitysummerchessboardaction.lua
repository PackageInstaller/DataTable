local var_0_0 = {}

function var_0_0.BindEvent()
	manager.notify:RegistListener(HISTORY_UPDATE, var_0_0.UpdateHistory)
	manager.notify:RegistListener(ACTIVITY_UPDATE, var_0_0.UpdateActivity)
	manager.notify:RegistListener(PLAYER_LEVEL_UP, var_0_0.UpdateHistory)
end

function var_0_0.UnbindEvent()
	manager.notify:RemoveListener(HISTORY_UPDATE, var_0_0.UpdateHistory)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, var_0_0.UpdateActivity)
	manager.notify:RemoveListener(PLAYER_LEVEL_UP, var_0_0.UpdateHistory)
end

function var_0_0.UpdateHistory()
	for iter_3_0, iter_3_1 in ipairs(ActivitySummerChessConditionCfg.all) do
		if ActivitySummerChessConditionCfg[iter_3_1].condition == 0 or HistoryData:GetHistoryData(ActivitySummerChessConditionCfg[iter_3_1].condition) and ActivityTools.GetActivityStatus(ActivitySummerChessConditionCfg[iter_3_1].activity_id) == ActivityConst.ACTIVITY_STATE.ACTIVING then
			var_0_0.InitNewTagRedPoint(ActivitySummerChessConditionCfg[iter_3_1].activity_id)
		end
	end
end

function var_0_0.UpdateActivity(arg_4_0)
	if ActivitySummerChessConditionCfg.get_id_list_by_activity_id[arg_4_0] then
		if ActivityTools.GetActivityStatus(arg_4_0) == ActivityConst.ACTIVITY_STATE.ACTIVING then
			for iter_4_0, iter_4_1 in ipairs(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[arg_4_0]) do
				local var_4_0 = ActivityUnlockStateData:GetUnlockState(ActivitySummerChessConditionCfg[iter_4_1].condition)

				if ActivitySummerChessConditionCfg[iter_4_1].condition == 0 or HistoryData:GetHistoryData(ActivitySummerChessConditionCfg[iter_4_1].condition) then
					var_0_0.InitNewTagRedPoint(arg_4_0)
				end
			end
		elseif SummerChessBoardData.SummerChessBoardActivityList[arg_4_0] then
			manager.redPoint:setTip(SummerChessBoardData:CallFun("GetEntryRedPointKey", arg_4_0), 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function var_0_0.InitPageRedPoint(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityCfg[arg_5_0].sub_activity_list) do
		table.insert(var_5_0, string.format("%s%s", ActivityTools.GetRedPointKey(iter_5_1), iter_5_1))
	end

	local var_5_1 = string.format("%s%s", ActivityTools.GetRedPointKey(arg_5_0), arg_5_0)

	if ActivityTools.GetActivityStatus(arg_5_0) == ActivityConst.ACTIVITY_STATE.ACTIVING then
		manager.redPoint:addGroup(var_5_1, var_5_0)
	else
		manager.redPoint:delGroup(var_5_1, var_5_0)
	end
end

function var_0_0.InitMainRedPoint(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivityCfg[arg_6_0].sub_activity_list) do
		table.insert(var_6_0, string.format("%s%s", ActivityTools.GetRedPointKey(iter_6_1), iter_6_1))
	end

	table.insert(var_6_0, string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, ActivityCfg[arg_6_0].activity_theme))
	table.insert(var_6_0, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_6_0), arg_6_0), var_6_0)
	ActivitySummerChessBoardAction.InitExploreRedPoint(arg_6_0)
end

function var_0_0.InitExploreRedPoint(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(ActivityCfg[arg_7_0].sub_activity_list) do
		if iter_7_1 ~= ActivityConst.ACTIVITY_SWIM_SKIN then
			table.insert(var_7_0, string.format("%s%s", ActivityTools.GetRedPointKey(iter_7_1), iter_7_1))
		end
	end

	table.insert(var_7_0, string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, ActivityCfg[arg_7_0].activity_theme))
	table.insert(var_7_0, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
	manager.redPoint:addGroup(RedPointConst.SUMMER_EXPLORE_BTN, var_7_0)
end

function var_0_0.InitRedPoint()
	local var_8_0 = SummerChessBoardData:GetSummerExploreRedPoint()

	var_0_0.InitExploreNoteRedPoint()
	var_0_0.InitExploreNoteNewRedPoint()
	table.insert(var_8_0, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE)
	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_AND_TASK), ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_AND_TASK), var_8_0)
	SummerChessBoardData:CreateTaskRedPointTree()
	var_0_0.InitAllNewTagRedPoint()
	SummerChessBoardData:GetBreakOutEventAndRedData()
end

function var_0_0.InitAllNewTagRedPoint()
	for iter_9_0, iter_9_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN].sub_activity_list) do
		if iter_9_1 == ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_AND_TASK then
			for iter_9_2, iter_9_3 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list) do
				var_0_0.InitNewTagRedPoint(iter_9_3)
			end
		elseif iter_9_1 ~= ActivityConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE then
			var_0_0.InitNewTagRedPoint(iter_9_1)
		end
	end
end

function var_0_0.InitNewTagRedPoint(arg_10_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT) then
		return
	end

	if ActivityTools.GetActivityStatus(arg_10_0) == ActivityConst.ACTIVITY_STATE.ACTIVING and SummerChessBoardData.SummerChessBoardActivityList[arg_10_0] then
		local var_10_0, var_10_1 = SummerChessBoardData:CallFun("CurrentUnlockStageID", arg_10_0)

		if var_10_0 and var_10_1 ~= 0 and ActivityUnlockStateData:GetUnlockState(var_10_1)[ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT] ~= 1 then
			manager.redPoint:setTip(SummerChessBoardData:CallFun("GetEntryRedPointKey", arg_10_0), 1, RedPointStyle.SHOW_NEW_TAG)
		end
	end

	manager.notify:Invoke(SUMMER_CHESS_BOARD_UNLOCK_NEW, arg_10_0)
end

function var_0_0.InitExploreNoteRedPoint()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.SUMMER_CHESS_BOARD_EXPLORE_NOTE))) do
		local var_11_1 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE, iter_11_0)

		table.insert(var_11_0, var_11_1)
		manager.redPoint:addGroup(var_11_1, {
			string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_REWARD, iter_11_0),
			string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_NEW, iter_11_0)
		})
	end

	manager.redPoint:addGroup(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE, var_11_0)
end

function var_0_0.InitExploreNoteNewRedPoint()
	TaskRedPoint:UpdateSummerExploreNoteRedTip()
end

function var_0_0.ReadExploreNoteNewText(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
		local var_13_0 = ActivityUnlockStateData:GetUnlockState(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE][1])

		if not var_13_0 or var_13_0[iter_13_1] ~= 1 then
			ActivityUnlockStateAction.UpdateState(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE][1], iter_13_1, 1)
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_NEW, iter_13_1), 0)
	end
end

function var_0_0.ReceiveAllExplorePhaseReward()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs((SummerChessBoardTools.GetPointIDList())) do
		if not ActivityPointData:IsCompleteID(iter_14_1) and ItemTools.getItemNum(ActivityPointRewardCfg[iter_14_1].need_item_id) >= ActivityPointRewardCfg[iter_14_1].need then
			table.insert(var_14_0, iter_14_1)
		end
	end

	ActivityPointAction.SubmitPointReward(var_14_0, function(arg_15_0)
		if isSuccess(arg_15_0.result) then
			manager.notify:Invoke(SUMMER_CHESS_BOARD_RECEIVE_PHASE_REWARD)
		else
			ShowTips(arg_15_0.result)
		end
	end)
end

return var_0_0
