local Guide_73 = class("Guide_73", BaseGuide)

function Guide_73:Check()
	if self:IsPlaying() then
		if manager.ChessBoardManager:GetIsCameraMoving() then
			manager.guide.view:Hide()
			manager.guide:SetIgnoreStuck(true)

			return false
		else
			return self._steps[1]:Check()
		end
	else
		if self:CheckGuide() and (manager.guide:CheckGroupLastTime(self.group) or #self.ignore_group_condition > 0 and GuideTool.SatisfyCondition(self.ignore_group_condition)) then
			return true
		end

		return false
	end
end

return Guide_73
