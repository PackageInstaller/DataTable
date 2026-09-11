local RogueCardEmptyStep = class("RogueCardEmptyStep", BaseStep)

function RogueCardEmptyStep:Init()
	RogueCardEmptyStep.super.Init(self)

	self._eventName = GuideStepCfg[self._stepId].params[1]
end

function RogueCardEmptyStep:Play()
	if self._stepId == 24705 or self._stepId == 24707 then
		RogueCard.RogueCardGameMain.Instance:ShowJokerSellGo(self._stepId == 24705)
		self:OnStepEnd()

		return
	end
end

return RogueCardEmptyStep
