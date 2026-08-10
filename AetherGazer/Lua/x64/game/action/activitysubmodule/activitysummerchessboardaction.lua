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
		local var_3_0 = ActivitySummerChessConditionCfg[iter_3_1]
		local var_3_1 = var_3_0.condition
		local var_3_2 = var_3_0.activity_id

		if var_3_1 == 0 or HistoryData:GetHistoryData(var_3_1) and ActivityTools.GetActivityStatus(var_3_2) == ActivityConst.ACTIVITY_STATE.ACTIVING then
			var_0_0.InitNewTagRedPoint(var_3_2)
		end
	end
end

function var_0_0.UpdateActivity(arg_4_0)
	local var_4_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[arg_4_0]

	if var_4_0 then
		if ActivityTools.GetActivityStatus(arg_4_0) == ActivityConst.ACTIVITY_STATE.ACTIVING then
			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				local var_4_1 = ActivitySummerChessConditionCfg[iter_4_1].condition
				local var_4_2 = ActivityUnlockStateData:GetUnlockState(var_4_1)

				if var_4_1 == 0 or HistoryData:GetHistoryData(var_4_1) then
					var_0_0.InitNewTagRedPoint(arg_4_0)
				end
			end
		elseif SummerChessBoardData.SummerChessBoardActivityList[arg_4_0] then
			manager.redPoint:setTip(SummerChessBoardData:CallFun("GetEntryRedPointKey", arg_4_0), 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function var_0_0.InitPageRedPoint(arg_5_0)
	local var_5_0 = ActivityCfg[arg_5_0].sub_activity_list
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		table.insert(var_5_1, string.format("%s%s", ActivityTools.GetRedPointKey(iter_5_1), iter_5_1))
	end

	local var_5_2 = string.format("%s%s", ActivityTools.GetRedPointKey(arg_5_0), arg_5_0)

	if ActivityTools.GetActivityStatus(arg_5_0) == ActivityConst.ACTIVITY_STATE.ACTIVING then
		manager.redPoint:addGroup(var_5_2, var_5_1)
	else
		manager.redPoint:delGroup(var_5_2, var_5_1)
	end
end

function var_0_0.InitMainRedPoint(arg_6_0)
	local var_6_0 = ActivityCfg[arg_6_0].sub_activity_list
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		table.insert(var_6_1, string.format("%s%s", ActivityTools.GetRedPointKey(iter_6_1), iter_6_1))
	end

	local var_6_2 = ActivityCfg[arg_6_0].activity_theme

	table.insert(var_6_1, string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, var_6_2))
	table.insert(var_6_1, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_6_0), arg_6_0), var_6_1)
	ActivitySummerChessBoardAction.InitExploreRedPoint(arg_6_0)
end

function var_0_0.InitExploreRedPoint(arg_7_0)
	local var_7_0 = ActivityCfg[arg_7_0].sub_activity_list
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1 ~= ActivityConst.ACTIVITY_SWIM_SKIN then
			table.insert(var_7_1, string.format("%s%s", ActivityTools.GetRedPointKey(iter_7_1), iter_7_1))
		end
	end

	local var_7_2 = ActivityCfg[arg_7_0].activity_theme

	table.insert(var_7_1, string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, var_7_2))
	table.insert(var_7_1, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)

	local var_7_3 = RedPointConst.SUMMER_EXPLORE_BTN

	manager.redPoint:addGroup(var_7_3, var_7_1)
end

function var_0_0.InitRedPoint()
	local var_8_0 = string.format("%s%s", ActivityTools.GetRedPointKey(ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_AND_TASK), ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_AND_TASK)
	local var_8_1 = SummerChessBoardData:GetSummerExploreRedPoint()

	var_0_0.InitExploreNoteRedPoint()
	var_0_0.InitExploreNoteNewRedPoint()
	table.insert(var_8_1, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE)
	manager.redPoint:addGroup(var_8_0, var_8_1)
	SummerChessBoardData:CreateTaskRedPointTree()
	var_0_0.InitAllNewTagRedPoint()
	SummerChessBoardData:GetBreakOutEventAndRedData()
end

function var_0_0.InitAllNewTagRedPoint()
	local var_9_0 = ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN]

	for iter_9_0, iter_9_1 in ipairs(var_9_0.sub_activity_list) do
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
	local var_11_0 = TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.SUMMER_CHESS_BOARD_EXPLORE_NOTE)
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_2 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE, iter_11_0)

		table.insert(var_11_1, var_11_2)
		manager.redPoint:addGroup(var_11_2, {
			string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_REWARD, iter_11_0),
			string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_NEW, iter_11_0)
		})
	end

	manager.redPoint:addGroup(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE, var_11_1)
end

function var_0_0.InitExploreNoteNewRedPoint()
	TaskRedPoint:UpdateSummerExploreNoteRedTip()
end

function var_0_0.ReadExploreNoteNewText(arg_13_0)
	local var_13_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE][1]

	for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
		local var_13_1 = ActivityUnlockStateData:GetUnlockState(var_13_0)

		if not var_13_1 or var_13_1[iter_13_1] ~= 1 then
			ActivityUnlockStateAction.UpdateState(var_13_0, iter_13_1, 1)
		end

		local var_13_2 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_NEW, iter_13_1)

		manager.redPoint:setTip(var_13_2, 0)
	end
end

function var_0_0.ReceiveAllExplorePhaseReward()
	local var_14_0 = {}
	local var_14_1 = SummerChessBoardTools.GetPointIDList()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = ActivityPointRewardCfg[iter_14_1]
		local var_14_3 = ItemTools.getItemNum(var_14_2.need_item_id)

		if not ActivityPointData:IsCompleteID(iter_14_1) and var_14_3 >= var_14_2.need then
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
