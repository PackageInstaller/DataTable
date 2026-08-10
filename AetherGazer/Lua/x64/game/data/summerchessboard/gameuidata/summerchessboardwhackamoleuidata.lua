local var_0_0 = import("..SummerChessBoardGameUIBaseData")
local var_0_1 = class("SummerChessBoardWhackAMoleUIData", var_0_0)

function var_0_1.GotoGameWindow(arg_1_0)
	WhackMoleData:SetSelected(arg_1_0.activityID_)
	JumpTools.GoToSystem("/whackMoleMain", {
		activityID = arg_1_0.activityID_
	})
end

function var_0_1.GetTaskIDList(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = WhackMoleTools.GetSessionList(arg_2_0.activityID_)
	local var_2_2 = 1

	for iter_2_0 = #var_2_1, 2, -1 do
		if not WhackMoleTools.GetSessionIsLock(arg_2_0.activityID_, iter_2_0) then
			var_2_2 = iter_2_0

			break
		end
	end

	local var_2_3 = AssignmentCfg.get_id_list_by_activity_id[arg_2_1]

	for iter_2_1, iter_2_2 in ipairs(var_2_3) do
		if var_2_2 >= AssignmentCfg[iter_2_2].phase then
			var_2_0[#var_2_0 + 1] = iter_2_2
		end
	end

	return var_2_0
end

return var_0_1
