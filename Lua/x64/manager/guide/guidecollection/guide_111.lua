local var_0_0 = class("Guide_111", BaseGuide)

function var_0_0.CheckGuide(arg_1_0)
	return BloodCardManager.Instance and BloodCardManager.Instance:GetCurrentStatus() == 8 and not BloodCardManager.Instance.isAbandon
end

function var_0_0.OnStepEnd(arg_2_0, arg_2_1)
	var_0_0.super.OnStepEnd(arg_2_0, arg_2_1)

	if arg_2_1:IsFinish() then
		BloodCardManager.Instance.guideID = 0
	end
end

function var_0_0.OnGuideStart(arg_3_0)
	BloodCardManager.Instance.guideID = arg_3_0._guideId
end

return var_0_0
