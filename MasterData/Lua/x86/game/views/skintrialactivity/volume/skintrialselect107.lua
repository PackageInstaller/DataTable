local SkinTrialSelect107 = class("SkinTrialSelect107", SkinTrialActivitySelectView)

function SkinTrialSelect107:UIName()
	return "UI/VolumeIIIDownUI/SkinTrial/VolumeSkinTrialUI_" .. self.params_.skinTrialID
end

function SkinTrialSelect107:RefreshUI()
	local var_2_0 = SkinTrialTools.GetHeroStandardID(self.skinTrialID_)
	local var_2_1 = HeroStandardSystemCfg[var_2_0].skin_id

	self.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_2_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_2_0].hero_id].suffix))

	local var_2_2 = SettingData:GetCurrentLanguage()

	if var_2_2 == "fr" or var_2_2 == "de" then
		self.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_2_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_2_0].hero_id].suffix))
	end

	self.skinDescText_.text = GetI18NText(SkinCfg[var_2_1].desc)

	self:RefreshReward()
end

return SkinTrialSelect107
