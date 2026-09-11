local Guide_111 = class("Guide_111", BaseGuide)

function Guide_111:CheckGuide()
	return BloodCardManager.Instance and BloodCardManager.Instance:GetCurrentStatus() == 8 and not BloodCardManager.Instance.isAbandon
end

function Guide_111:OnStepEnd(arg_2_1)
	Guide_111.super.OnStepEnd(self, arg_2_1)

	if arg_2_1:IsFinish() then
		BloodCardManager.Instance.guideID = 0
	end
end

function Guide_111:OnGuideStart()
	BloodCardManager.Instance.guideID = self._guideId
end

return Guide_111
