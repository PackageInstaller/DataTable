local var_0_0 = singletonClass("SummerChessBoardData")

var_0_0.SummerChessBoardActivityList = {
	[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_1] = import("game.data.summerChessBoard.gameUIData.SummerChessBoardChessUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_2] = import("game.data.summerChessBoard.gameUIData.SummerChessBoardChessUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_3] = import("game.data.summerChessBoard.gameUIData.SummerChessBoardChessUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_4] = import("game.data.summerChessBoard.gameUIData.SummerChessBoardChessUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_5] = import("game.data.summerChessBoard.gameUIData.SummerChessBoardChessUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_RHYTHM] = import("game.data.summerChessBoard.gameUIData.SummerRhythmUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_NONSTER_COSPLAY] = import("game.data.summerChessBoard.gameUIData.SummerChessMonsterCosplayUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_WHAC_A_MOLE] = import("game.data.summerChessBoard.gameUIData.SummerChessBoardWhackAMoleUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_DUCK] = import("game.data.summerChessBoard.gameUIData.SummerChessBoardCatchDuckUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_BUBBLE] = import("game.data.summerChessBoard.gameUIData.SummerBlisterUIData"),
	[ActivityConst.SUMMER_CHESS_BOARD_PLUZZE] = import("game.data.summerChessBoard.gameUIData.SummerTangramGameData")
}

function var_0_0.Init(arg_1_0)
	arg_1_0.summerChessBoardData_ = {}
end

function var_0_0.InitActivityData(arg_2_0, arg_2_1)
	if arg_2_0.summerChessBoardData_[arg_2_1] == nil then
		arg_2_0.summerChessBoardData_[arg_2_1] = var_0_0.SummerChessBoardActivityList[arg_2_1].New(arg_2_1)
	end
end

function var_0_0.CallFun(arg_3_0, arg_3_1, arg_3_2, ...)
	arg_3_0:InitActivityData(arg_3_2)

	return arg_3_0.summerChessBoardData_[arg_3_2][arg_3_1](arg_3_0.summerChessBoardData_[arg_3_2], ...)
end

function var_0_0.CreateTaskRedPointTree(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(ActivitySummerTaskGroupUICfg.get_id_list_by_theme) do
		local var_4_0 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, iter_4_0)
		local var_4_1 = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			local var_4_2 = string.format("%s_%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, iter_4_0, iter_4_3)

			table.insert(var_4_1, var_4_2)

			local var_4_3 = ActivitySummerTaskGroupUICfg[iter_4_3].item_id_list

			if #var_4_3 > 0 then
				local var_4_4 = {}

				for iter_4_4, iter_4_5 in ipairs(var_4_3) do
					local var_4_5 = ActivitySummerTaskItemUICfg[iter_4_5]
					local var_4_6 = arg_4_0:CallFun("GetTaskRedPointKey", var_4_5.main_activity_id, var_4_5.activity_id)

					table.insert(var_4_4, var_4_6)
				end

				manager.redPoint:addGroup(var_4_2, var_4_4)
			elseif ActivitySummerTaskGroupUICfg[iter_4_3].main_activity_id == ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS then
				manager.redPoint:addGroup(var_4_2, arg_4_0:GetSummerExploreTaskRedPointTree())
			end
		end

		manager.redPoint:addGroup(var_4_0, var_4_1)
	end
end

function var_0_0.GetSummerExploreTaskRedPointTree(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_TASK].sub_activity_list) do
		local var_5_1 = ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list[iter_5_0]
		local var_5_2 = arg_5_0:CallFun("GetTaskRedPointKey", var_5_1, iter_5_1)

		table.insert(var_5_0, var_5_2)
	end

	for iter_5_2, iter_5_3 in ipairs(SummerChessBoardChessTaskView.PHASE_ACTIVITY) do
		local var_5_3 = string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, iter_5_3)

		table.insert(var_5_0, var_5_3)
	end

	return var_5_0
end

function var_0_0.GetSummerExploreRedPoint(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list) do
		local var_6_1 = arg_6_0:CallFun("GetEntryRedPointKey", iter_6_1)

		table.insert(var_6_0, var_6_1)
	end

	return var_6_0
end

function var_0_0.GetBreakOutEventAndRedData(arg_7_0)
	local var_7_0 = TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.SUMMER_CHESS_EMERGENCY)

	if not ActivityData:GetActivityIsOpen(ActivityConst.SUMMER_CHESS_BOARD_EMERGENCY) then
		manager.redPoint:setTip(RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY, 0)

		return 0
	end

	local var_7_1 = false
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_3 = TaskData2:GetTask(iter_7_0)
		local var_7_4 = ActivityEmergencyCfg[iter_7_0].condition
		local var_7_5 = AssignmentCfg[iter_7_0]

		if var_7_3.complete_flag < 1 and HistoryData:GetHistoryData(var_7_4) then
			if var_7_3.progress >= var_7_5.need then
				var_7_1 = true
			end

			var_7_2 = iter_7_0

			break
		end
	end

	if not var_7_1 and var_7_2 > 0 then
		local var_7_6 = manager.time:GetServerTime()
		local var_7_7 = getData("SummerChessBoard", USER_ID .. "EmergencyTime") or 0

		if not manager.time:CheckIsToday(var_7_6, var_7_7) then
			var_7_1 = true
		end
	end

	manager.redPoint:setTip(RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY, var_7_1 and 1 or 0)

	return var_7_2
end

return var_0_0
