local SummerBlisterUIData = class("SummerBlisterUIData", (import("..SummerChessBoardGameUIBaseData")))

function SummerBlisterUIData:GotoGameWindow()
	JumpTools.GoToSystem("/blisterGame", {
		activityID = self.activityID_
	})
end

function SummerBlisterUIData:GetTaskRedPointKey(arg_2_1, arg_2_2)
	return string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_2_1)
end

function SummerBlisterUIData:GetTaskIDList(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs((ActivityCfg[arg_3_1] or nil) and (ActivityCfg[arg_3_1].sub_activity_list or {})) do
		local var_3_1 = AssignmentCfg.get_id_list_by_activity_id[iter_3_1] or {}
		local var_3_2 = BlisterGameTool.GetSessionIsLock(ActivityConst.SUMMER_CHESS_BOARD_BUBBLE, iter_3_0)

		for iter_3_2, iter_3_3 in pairs(var_3_1) do
			if not var_3_2 and ActivityData:GetActivityIsOpen(AssignmentCfg[iter_3_3].activity_id) or iter_3_0 == 1 then
				table.insert(var_3_0, iter_3_3)
			end
		end
	end

	return var_3_0
end

return SummerBlisterUIData
