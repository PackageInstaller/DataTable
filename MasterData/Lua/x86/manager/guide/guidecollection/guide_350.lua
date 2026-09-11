local Guide_350 = class("Guide_350", BaseGuide)

function Guide_350:Check()
	if self:IsPlaying() then
		local var_1_0 = self._steps[1]
		local var_1_1 = gameContext:IsOpenRoute("summerRaceCutScenesPopView") ~= nil

		if var_1_1 then
			manager.guide.view:Hide()
		end

		if var_1_0 ~= nil and var_1_0:GetStepId() == 35002 and var_1_1 then
			return false
		end
	end

	return Guide_350.super.Check(self)
end

return Guide_350
