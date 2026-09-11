local SummerChessBoardCatchDuckUIData = class("SummerChessBoardCatchDuckUIData", (import("..SummerChessBoardGameUIBaseData")))

function SummerChessBoardCatchDuckUIData:GotoGameWindow()
	JumpTools.GoToSystem("/catchDuckMain")
end

function SummerChessBoardCatchDuckUIData:GetTaskIDList(arg_2_1)
	local var_2_0 = AssignmentCfg.get_id_list_by_activity_id[arg_2_1]
	local var_2_1 = {}
	local var_2_2, var_2_3 = self:CurrentUnlockStageID()

	if CatchDuckData:IsOpenSecondHalf() and var_2_2 then
		local var_2_4 = CatchDuckData:GetConditionId(2) or CatchDuckData:GetConditionId(1)

		if var_2_4 then
			for iter_2_0, iter_2_1 in ipairs(var_2_0) do
				if var_2_4 >= AssignmentCfg[iter_2_1].phase then
					var_2_1[#var_2_1 + 1] = iter_2_1
				end
			end
		end
	end

	return var_2_1
end

return SummerChessBoardCatchDuckUIData
