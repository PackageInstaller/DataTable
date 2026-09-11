local SummerRhythmUIData = class("SummerRhythmUIData", (import("..SummerChessBoardGameUIBaseData")))

function SummerRhythmUIData:GotoGameWindow()
	JumpTools.OpenPageByJump("/activityRhythmGameStageView", {
		activityID = self.activityID_
	})
end

function SummerRhythmUIData:GetTaskIDList(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs((ActivityCfg[arg_2_1] or nil) and (ActivityCfg[arg_2_1].sub_activity_list or {})) do
		local var_2_1 = AssignmentCfg.get_id_list_by_activity_id[iter_2_1] or {}
		local var_2_2 = ActivityRhythmGameTools.GetSessionIsLock(ActivityConst.SUMMER_CHESS_BOARD_RHYTHM, iter_2_0)

		for iter_2_2, iter_2_3 in pairs(var_2_1) do
			if not var_2_2 and ActivityData:GetActivityIsOpen(AssignmentCfg[iter_2_3].activity_id) or iter_2_0 == 1 then
				table.insert(var_2_0, iter_2_3)
			end
		end
	end

	return var_2_0
end

return SummerRhythmUIData
