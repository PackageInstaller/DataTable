local AffixSettingToggle = class("AffixSettingToggle", BaseSettingToggle)

function AffixSettingToggle:Ctor(arg_1_1)
	self.params_ = arg_1_1
end

function AffixSettingToggle:GetName()
	return "Affix"
end

function AffixSettingToggle:UIClass()
	if self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE then
		return SoloChallengeAffixDescriptionView
	elseif self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
		return RaceTrialAffixDescriptionView
	else
		return AffixDescriptionView
	end
end

function AffixSettingToggle:GetPath()
	return "Widget/System/Setting/AffixDescriptionUI"
end

function AffixSettingToggle:Order()
	return 16
end

function AffixSettingToggle:RedPointKey()
	return nil
end

function AffixSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting08")
end

function AffixSettingToggle:GetParams()
	return self.params_.affixData
end

function AffixSettingToggle:IsSetting()
	return false
end

return AffixSettingToggle
