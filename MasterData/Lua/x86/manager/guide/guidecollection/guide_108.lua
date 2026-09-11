local Guide_108 = class("Guide_108", BaseGuide)

function Guide_108:CheckGuide()
	return BloodCardManager.Instance and BloodCardManager.Instance.guideIndex == 1 and BloodCardManager.Instance.isDrawCardDone
end

function Guide_108:OnStepEnd(arg_2_1)
	if arg_2_1:IsFinish() then
		BloodCardManager.Instance.guideID = 0
	end

	BloodCardManager.Instance.stepID = arg_2_1:GetStepId()

	if arg_2_1:GetStepId() == 10806 then
		BloodCardManager.Instance:LockHandCard(true)
	elseif arg_2_1:GetStepId() == 10807 then
		BloodCardManager.Instance:LockHandCard(false)
	end

	Guide_108.super.OnStepEnd(self, arg_2_1)
end

function Guide_108:OnGuideStart()
	BloodCardManager.Instance.guideID = self._guideId
end

return Guide_108
