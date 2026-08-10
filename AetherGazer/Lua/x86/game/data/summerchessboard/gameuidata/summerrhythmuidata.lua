local var_0_0 = import("..SummerChessBoardGameUIBaseData")
local var_0_1 = class("SummerRhythmUIData", var_0_0)

function var_0_1.GotoGameWindow(arg_1_0)
	JumpTools.OpenPageByJump("/activityRhythmGameStageView", {
		activityID = arg_1_0.activityID_
	})
end

function var_0_1.GetTaskIDList(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = ActivityCfg[arg_2_1] and ActivityCfg[arg_2_1].sub_activity_list or {}

	for iter_2_0, iter_2_1 in pairs(var_2_1) do
		local var_2_2 = AssignmentCfg.get_id_list_by_activity_id[iter_2_1] or {}
		local var_2_3 = ActivityRhythmGameTools.GetSessionIsLock(ActivityConst.SUMMER_CHESS_BOARD_RHYTHM, iter_2_0)

		for iter_2_2, iter_2_3 in pairs(var_2_2) do
			local var_2_4 = ActivityData:GetActivityIsOpen(AssignmentCfg[iter_2_3].activity_id)

			if not var_2_3 and var_2_4 or iter_2_0 == 1 then
				table.insert(var_2_0, iter_2_3)
			end
		end
	end

	return var_2_0
end

return var_0_1
