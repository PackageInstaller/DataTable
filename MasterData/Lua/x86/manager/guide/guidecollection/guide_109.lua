local Guide_109 = class("Guide_109", BaseGuide)

function Guide_109:CheckGuide()
	return BloodCardManager.Instance and BloodCardManager.Instance.guideIndex == 2 and BloodCardManager.Instance.isDealCardDone
end

function Guide_109:OnStepEnd(arg_2_1)
	if arg_2_1:IsFinish() then
		BloodCardManager.Instance.guideID = 0
	end

	Guide_109.super.OnStepEnd(self, arg_2_1)
end

function Guide_109:OnGuideStart()
	BloodCardManager.Instance.guideID = self._guideId
end

return Guide_109
