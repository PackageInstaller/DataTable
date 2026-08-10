local var_0_0 = class("Guide_108", BaseGuide)

function var_0_0.CheckGuide(arg_1_0)
	return BloodCardManager.Instance and BloodCardManager.Instance.guideIndex == 1 and BloodCardManager.Instance.isDrawCardDone
end

function var_0_0.OnStepEnd(arg_2_0, arg_2_1)
	if arg_2_1:IsFinish() then
		BloodCardManager.Instance.guideID = 0
	end

	BloodCardManager.Instance.stepID = arg_2_1:GetStepId()

	if arg_2_1:GetStepId() == 10806 then
		BloodCardManager.Instance:LockHandCard(true)
	elseif arg_2_1:GetStepId() == 10807 then
		BloodCardManager.Instance:LockHandCard(false)
	end

	var_0_0.super.OnStepEnd(arg_2_0, arg_2_1)
end

function var_0_0.OnGuideStart(arg_3_0)
	BloodCardManager.Instance.guideID = arg_3_0._guideId
end

return var_0_0
