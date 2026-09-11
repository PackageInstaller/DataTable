local WaitBattleResultStep = class("WaitBattleResultStep", BaseStep)

function WaitBattleResultStep:Init(arg_1_1)
	self._failSteps = GuideStepCfg[self._stepId].params
end

function WaitBattleResultStep:BattleFinish(arg_2_1)
	if not isSuccess(arg_2_1) then
		self._guide:AddSteps(self._failSteps)

		if self._isFinish then
			self._isFinish = false
		end
	end

	self:OnStepEnd()
end

function WaitBattleResultStep:IsFinish()
	return self._isFinish
end

return WaitBattleResultStep
