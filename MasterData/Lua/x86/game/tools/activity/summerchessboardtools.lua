local var_0_0 = {
	GetPointIDList = function()
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in ipairs(SummerChessBoardChessTaskView.PHASE_ACTIVITY) do
			if ActivityTools.GetActivityStatus(iter_1_1) == ActivityConst.ACTIVITY_STATE.ACTIVING then
				table.insertto(var_1_0, clone(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_1_1]) or {})
			end
		end

		return var_1_0
	end
}

function var_0_0.GetChessExploreIndex()
	local var_2_0 = var_0_0.GetPointIDList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if not ActivityPointData:IsCompleteID(iter_2_1) then
			return iter_2_0
		end
	end

	return #var_2_0
end

function var_0_0.GetChessExploreFinishCnt()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs((var_0_0.GetPointIDList())) do
		if ActivityPointData:IsCompleteID(iter_3_1) then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

function var_0_0.GetTaskRewardPhase()
	local var_4_0 = 1

	for iter_4_0, iter_4_1 in ipairs(SummerChessBoardChessTaskView.PHASE_ACTIVITY) do
		if ActivityTools.GetActivityStatus(iter_4_1) ~= ActivityConst.ACTIVITY_STATE.ACTIVING then
			break
		end

		local var_4_1 = ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[iter_4_1][#ActivityPointRewardCfg.get_id_list_by_activity_id[iter_4_1]]]

		var_4_0 = iter_4_0

		if ItemTools.getItemNum(var_4_1.need_item_id) < var_4_1.need then
			break
		end
	end

	return var_4_0
end

function var_0_0.GetNextPhasePointValue()
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(SummerChessBoardChessTaskView.PHASE_ACTIVITY) do
		if ActivityTools.GetActivityStatus(iter_5_1) ~= ActivityConst.ACTIVITY_STATE.ACTIVING then
			break
		end

		local var_5_1 = ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[iter_5_1][#ActivityPointRewardCfg.get_id_list_by_activity_id[iter_5_1]]]

		var_5_0 = var_5_1.need

		if ItemTools.getItemNum(var_5_1.need_item_id) < var_5_1.need then
			break
		end
	end

	return var_5_0
end

function var_0_0.GetPointItemID()
	return ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[SummerChessBoardChessTaskView.PHASE_ACTIVITY[1]][#ActivityPointRewardCfg.get_id_list_by_activity_id[SummerChessBoardChessTaskView.PHASE_ACTIVITY[1]]]].need_item_id
end

function var_0_0.GetTaskGroupIndex(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(ActivitySummerTaskGroupUICfg.get_id_list_by_theme[ActivityCfg[arg_7_0].activity_theme] or {}) do
		if arg_7_0 == ActivitySummerTaskGroupUICfg[iter_7_1].activity_id then
			return iter_7_0, 1
		else
			for iter_7_2, iter_7_3 in ipairs(ActivitySummerTaskGroupUICfg[iter_7_1].item_id_list) do
				if arg_7_0 == ActivitySummerTaskItemUICfg[iter_7_3].activity_id then
					return iter_7_0, iter_7_2
				end
			end
		end
	end

	return 1, 1
end

function var_0_0.GetSummerChesssBoardTaskExploreID()
	for iter_8_0, iter_8_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list) do
		for iter_8_2, iter_8_3 in ipairs((SummerChessBoardData:CallFun("GetTaskIDList", iter_8_1, ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_TASK].sub_activity_list[iter_8_0]))) do
			if AssignmentCfg[iter_8_3] and not TaskData2:GetTaskComplete(iter_8_3) and TaskData2:GetTaskProgress(iter_8_3) < AssignmentCfg[iter_8_3].need then
				return iter_8_3
			end
		end
	end

	return 0
end

function var_0_0.GetFinishExploreNoteList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.SUMMER_CHESS_BOARD_EXPLORE_NOTE))) do
		if TaskData2:GetTaskProgress(iter_9_0) >= AssignmentCfg[iter_9_0].need then
			table.insert(var_9_0, iter_9_0)
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0 < arg_10_1
	end)

	local var_9_1 = {}

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		table.insert(var_9_1, iter_9_3)

		if iter_9_3 == GameSetting.summer_note_video.value[1] then
			table.insert(var_9_1, 1)
		end
	end

	local var_9_2 = {}

	for iter_9_4, iter_9_5 in ipairs(var_9_1) do
		local var_9_3 = math.floor((iter_9_4 - 1) / 4) + 1

		var_9_2[var_9_3] = var_9_2[var_9_3] or {}
		var_9_2[var_9_3][(iter_9_4 % 4 == 0 or nil) and 4] = iter_9_5
	end

	return var_9_2
end

function var_0_0.GetTaskIDByChessBoardID(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list) do
		if arg_11_0 == iter_11_1 then
			return ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_TASK].sub_activity_list[iter_11_0]
		end
	end
end

return var_0_0
