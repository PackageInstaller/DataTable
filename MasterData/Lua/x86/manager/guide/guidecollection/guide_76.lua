local Guide_76 = class("Guide_76", BaseGuide)

function Guide_76:Check()
	if self:IsPlaying() then
		local var_1_0 = manager.ChessBoardManager

		if manager.ChessBoardManager then
			if self._steps[1]._stepId == 7601 and (not var_1_0:GetIsCanUseProp() or not var_1_0:ContainProp(self._steps[1]._params[2])) then
				manager.guide.view:Hide()
				manager.guide:SetIgnoreStuck(true)

				return false
			else
				return self._steps[1]:Check()
			end
		else
			return false
		end
	else
		if self:CheckGuide() and (manager.guide:CheckGroupLastTime(self.group) or #self.ignore_group_condition > 0 and GuideTool.SatisfyCondition(self.ignore_group_condition)) then
			return true
		end

		return false
	end
end

return Guide_76
