local var_0_0 = class("Guide_73", BaseGuide)

function var_0_0.Check(arg_1_0)
	if arg_1_0:IsPlaying() then
		if manager.ChessBoardManager:GetIsCameraMoving() then
			manager.guide.view:Hide()
			manager.guide:SetIgnoreStuck(true)

			return false
		else
			return arg_1_0._steps[1]:Check()
		end
	else
		if arg_1_0:CheckGuide() and (manager.guide:CheckGroupLastTime(arg_1_0.group) or #arg_1_0.ignore_group_condition > 0 and GuideTool.SatisfyCondition(arg_1_0.ignore_group_condition)) then
			return true
		end

		return false
	end
end

return var_0_0
