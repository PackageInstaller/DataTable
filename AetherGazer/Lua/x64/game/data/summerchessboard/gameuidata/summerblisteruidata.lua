local var_0_0 = import("..SummerChessBoardGameUIBaseData")
local var_0_1 = class("SummerBlisterUIData", var_0_0)

function var_0_1.GotoGameWindow(arg_1_0)
	JumpTools.GoToSystem("/blisterGame", {
		activityID = arg_1_0.activityID_
	})
end

function var_0_1.GetTaskRedPointKey(arg_2_0, arg_2_1, arg_2_2)
	return string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_2_1)
end

function var_0_1.GetTaskIDList(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = ActivityCfg[arg_3_1] and ActivityCfg[arg_3_1].sub_activity_list or {}

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		local var_3_2 = AssignmentCfg.get_id_list_by_activity_id[iter_3_1] or {}
		local var_3_3 = BlisterGameTool.GetSessionIsLock(ActivityConst.SUMMER_CHESS_BOARD_BUBBLE, iter_3_0)

		for iter_3_2, iter_3_3 in pairs(var_3_2) do
			local var_3_4 = ActivityData:GetActivityIsOpen(AssignmentCfg[iter_3_3].activity_id)

			if not var_3_3 and var_3_4 or iter_3_0 == 1 then
				table.insert(var_3_0, iter_3_3)
			end
		end
	end

	return var_3_0
end

return var_0_1
