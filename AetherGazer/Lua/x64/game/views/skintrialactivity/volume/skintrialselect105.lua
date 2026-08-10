local var_0_0 = class("SkinTrialSelect105", SkinTrialActivitySelectView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeSkinTrialUI_" .. arg_1_0.params_.skinTrialID
end

function var_0_0.RefreshUI(arg_2_0)
	arg_2_0:RefreshReward()
end

function var_0_0.OnEnter(arg_3_0)
	if arg_3_0.params_.canPlayAnim == true and arg_3_0.animator_ ~= nil then
		arg_3_0.params_.canPlayAnim = false

		arg_3_0.animator_:Play("VolumeSkinTrialUI_105_02", -1, 0)
	else
		arg_3_0.animator_:Play("VolumeSkinTrialUI_105_01", -1, 0)
	end

	var_0_0.super.OnEnter(arg_3_0)

	local var_3_0 = arg_3_0.skinTrialID_
	local var_3_1 = ActivitySkinTrialCfg[var_3_0].trial_id
	local var_3_2 = HeroStandardSystemCfg[var_3_1].skin_id

	arg_3_0.skinDescText_.text = GetI18NText(SkinCfg[var_3_2].desc)
end

return var_0_0
