local var_0_0 = import("..SummerChessBoardGameUIBaseData")
local var_0_1 = class("SummerChessBoardChessUIData", var_0_0)

function var_0_1.GotoGameWindow(arg_1_0)
	local var_1_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

	if var_1_0 ~= 0 then
		JumpTools.OpenPageByJump("summerChessBoardLevelView", {
			activityID = arg_1_0.activityID_,
			selectLevelID = var_1_0
		})
	else
		JumpTools.OpenPageByJump("summerChessBoardLevelView", {
			selectLevelID = 0,
			activityID = arg_1_0.activityID_
		})
	end
end

function var_0_1.GetTaskIDList(arg_2_0, arg_2_1)
	local var_2_0 = TaskData2:GetTaskIDListByActivity(arg_2_1)
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		table.insert(var_2_1, iter_2_0)
	end

	table.sort(var_2_1, function(arg_3_0, arg_3_1)
		return arg_3_0 < arg_3_1
	end)

	return var_2_1
end

function var_0_1.GetTaskIDListInLevelID(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = TaskData2:GetTaskIDListByActivity(arg_4_1)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_2 = AssignmentCfg[iter_4_0]

		if var_4_2 and var_4_2.phase and var_4_2.phase == arg_4_2 then
			table.insert(var_4_1, iter_4_0)
		end
	end

	table.sort(var_4_1, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	return var_4_1
end

function var_0_1.IsUnlockGamePlay(arg_6_0)
	local var_6_0 = arg_6_0.activityID_
	local var_6_1 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_6_0] or {}

	if #var_6_1 <= 0 then
		return true
	end

	local var_6_2 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_3 = ActivitySummerChessConditionCfg[iter_6_1].condition

		if var_6_3 == 0 or IsConditionAchieved(var_6_3) then
			return true
		end
	end

	return false
end

return var_0_1
