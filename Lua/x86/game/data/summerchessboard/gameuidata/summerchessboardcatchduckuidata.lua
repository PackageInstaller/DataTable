local var_0_0 = import("..SummerChessBoardGameUIBaseData")
local var_0_1 = class("SummerChessBoardCatchDuckUIData", var_0_0)

function var_0_1.GotoGameWindow(arg_1_0)
	JumpTools.GoToSystem("/catchDuckMain")
end

function var_0_1.GetTaskIDList(arg_2_0, arg_2_1)
	local var_2_0 = AssignmentCfg.get_id_list_by_activity_id[arg_2_1]
	local var_2_1 = {}
	local var_2_2, var_2_3 = arg_2_0:CurrentUnlockStageID()
	local var_2_4 = CatchDuckData:IsOpenSecondHalf() and var_2_2 and CatchDuckData:GetConditionId(2) or CatchDuckData:GetConditionId(1)

	if var_2_4 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if var_2_4 >= AssignmentCfg[iter_2_1].phase then
				var_2_1[#var_2_1 + 1] = iter_2_1
			end
		end
	end

	return var_2_1
end

return var_0_1
