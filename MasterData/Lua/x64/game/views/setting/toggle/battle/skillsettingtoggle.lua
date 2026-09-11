local SkillSettingToggle = class("SkillSettingToggle", BaseSettingToggle)

function SkillSettingToggle:Ctor(arg_1_1)
	self.params_ = arg_1_1
end

function SkillSettingToggle:GetName()
	return "Skill"
end

function SkillSettingToggle:UIClass()
	return SkillDescriptionView
end

function SkillSettingToggle:GetPath()
	return "Widget/System/Setting/SkillSettingUI"
end

function SkillSettingToggle:Order()
	return 20
end

function SkillSettingToggle:RedPointKey()
	return nil
end

function SkillSettingToggle:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting11")
end

function SkillSettingToggle:GetParams()
	return self.params_.stageData
end

function SkillSettingToggle:IsSetting()
	return false
end

return SkillSettingToggle
