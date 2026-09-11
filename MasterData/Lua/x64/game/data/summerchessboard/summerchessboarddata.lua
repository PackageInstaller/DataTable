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

function var_0_0:InitActivityData(arg_2_1)
	if self.summerChessBoardData_[arg_2_1] == nil then
		self.summerChessBoardData_[arg_2_1] = var_0_0.SummerChessBoardActivityList[arg_2_1].New(arg_2_1)
	end
end

function var_0_0:CallFun(arg_3_1, arg_3_2, ...)
	self:InitActivityData(arg_3_2)

	return self.summerChessBoardData_[arg_3_2][arg_3_1](self.summerChessBoardData_[arg_3_2], ...)
end

function var_0_0:CreateTaskRedPointTree()
	for iter_4_0, iter_4_1 in pairs(ActivitySummerTaskGroupUICfg.get_id_list_by_theme) do
		local var_4_0 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, iter_4_0)
		local var_4_1 = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			local var_4_2 = string.format("%s_%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, iter_4_0, iter_4_3)

			table.insert(var_4_1, var_4_2)

			if #ActivitySummerTaskGroupUICfg[iter_4_3].item_id_list > 0 then
				local var_4_3 = {}

				for iter_4_4, iter_4_5 in ipairs(ActivitySummerTaskGroupUICfg[iter_4_3].item_id_list) do
					table.insert(var_4_3, (self:CallFun("GetTaskRedPointKey", ActivitySummerTaskItemUICfg[iter_4_5].main_activity_id, ActivitySummerTaskItemUICfg[iter_4_5].activity_id)))
				end

				manager.redPoint:addGroup(var_4_2, var_4_3)
			elseif ActivitySummerTaskGroupUICfg[iter_4_3].main_activity_id == ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS then
				manager.redPoint:addGroup(var_4_2, self:GetSummerExploreTaskRedPointTree())
			end
		end

		manager.redPoint:addGroup(var_4_0, var_4_1)
	end
end

function var_0_0:GetSummerExploreTaskRedPointTree()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_TASK].sub_activity_list) do
		table.insert(var_5_0, (self:CallFun("GetTaskRedPointKey", ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list[iter_5_0], iter_5_1)))
	end

	for iter_5_2, iter_5_3 in ipairs(SummerChessBoardChessTaskView.PHASE_ACTIVITY) do
		table.insert(var_5_0, (string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, iter_5_3)))
	end

	return var_5_0
end

function var_0_0:GetSummerExploreRedPoint()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list) do
		table.insert(var_6_0, (self:CallFun("GetEntryRedPointKey", iter_6_1)))
	end

	return var_6_0
end

function var_0_0.GetBreakOutEventAndRedData(arg_7_0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.SUMMER_CHESS_BOARD_EMERGENCY) then
		manager.redPoint:setTip(RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY, 0)

		return 0
	end

	local var_7_0 = false
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.SUMMER_CHESS_EMERGENCY))) do
		local var_7_2 = TaskData2:GetTask(iter_7_0)

		if var_7_2.complete_flag < 1 and HistoryData:GetHistoryData(ActivityEmergencyCfg[iter_7_0].condition) then
			if var_7_2.progress >= AssignmentCfg[iter_7_0].need then
				var_7_0 = true
			end

			var_7_1 = iter_7_0

			break
		end
	end

	if not var_7_0 and var_7_1 > 0 then
		if not manager.time:CheckIsToday(manager.time:GetServerTime(), getData("SummerChessBoard", USER_ID .. "EmergencyTime") or 0) then
			var_7_0 = true
		end
	end

	manager.redPoint:setTip(RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY, var_7_0 and 1 or 0)

	return var_7_1
end

return var_0_0
