local var_0_0 = class("Guide_74", BaseGuide)

function var_0_0.Check(arg_1_0)
	if arg_1_0:IsPlaying() then
		local var_1_0 = manager.ChessBoardManager

		if var_1_0 then
			if arg_1_0._steps[1]._stepId == 7401 and (not var_1_0:GetIsCanUseProp() or not (#var_1_0:GetHeroProp() > 0)) then
				manager.guide.view:Hide()
				manager.guide:SetIgnoreStuck(true)

				return false
			else
				return arg_1_0._steps[1]:Check()
			end
		else
			return false
		end
	else
		if arg_1_0:CheckGuide() and (manager.guide:CheckGroupLastTime(arg_1_0.group) or #arg_1_0.ignore_group_condition > 0 and GuideTool.SatisfyCondition(arg_1_0.ignore_group_condition)) then
			return true
		end

		return false
	end
end

return var_0_0
