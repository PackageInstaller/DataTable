local SummerChessBoardChessUIData = class("SummerChessBoardChessUIData", (import("..SummerChessBoardGameUIBaseData")))

function SummerChessBoardChessUIData:GotoGameWindow()
	local var_1_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

	if var_1_0 ~= 0 then
		JumpTools.OpenPageByJump("summerChessBoardLevelView", {
			activityID = self.activityID_,
			selectLevelID = var_1_0
		})
	else
		JumpTools.OpenPageByJump("summerChessBoardLevelView", {
			selectLevelID = 0,
			activityID = self.activityID_
		})
	end
end

function SummerChessBoardChessUIData:GetTaskIDList(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs((TaskData2:GetTaskIDListByActivity(arg_2_1))) do
		table.insert(var_2_0, iter_2_0)
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0 < arg_3_1
	end)

	return var_2_0
end

function SummerChessBoardChessUIData:GetTaskIDListInLevelID(arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs((TaskData2:GetTaskIDListByActivity(arg_4_1))) do
		if AssignmentCfg[iter_4_0] and AssignmentCfg[iter_4_0].phase and AssignmentCfg[iter_4_0].phase == arg_4_2 then
			table.insert(var_4_0, iter_4_0)
		end
	end

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	return var_4_0
end

function SummerChessBoardChessUIData:IsUnlockGamePlay()
	local var_6_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[self.activityID_] or {}

	if #var_6_0 <= 0 then
		return true
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if ActivitySummerChessConditionCfg[iter_6_1].condition == 0 or IsConditionAchieved(ActivitySummerChessConditionCfg[iter_6_1].condition) then
			return true
		end
	end

	return false
end

return SummerChessBoardChessUIData
