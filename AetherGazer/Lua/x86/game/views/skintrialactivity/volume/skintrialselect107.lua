local var_0_0 = class("SkinTrialSelect107", SkinTrialActivitySelectView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/SkinTrial/VolumeSkinTrialUI_" .. arg_1_0.params_.skinTrialID
end

function var_0_0.RefreshUI(arg_2_0)
	local var_2_0 = arg_2_0.skinTrialID_
	local var_2_1 = SkinTrialTools.GetHeroStandardID(var_2_0)
	local var_2_2 = HeroStandardSystemCfg[var_2_1].skin_id
	local var_2_3 = HeroStandardSystemCfg[var_2_1].hero_id

	arg_2_0.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[var_2_3].name), GetI18NText(HeroCfg[var_2_3].suffix))

	local var_2_4 = SettingData:GetCurrentLanguage()

	if var_2_4 == "fr" or var_2_4 == "de" then
		arg_2_0.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[var_2_3].name), GetI18NText(HeroCfg[var_2_3].suffix))
	end

	arg_2_0.skinDescText_.text = GetI18NText(SkinCfg[var_2_2].desc)

	arg_2_0:RefreshReward()
end

return var_0_0
