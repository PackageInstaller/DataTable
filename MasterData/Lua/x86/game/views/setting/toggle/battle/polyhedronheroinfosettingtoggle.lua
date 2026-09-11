local PolyhedronHeroInfoSettingTogglee = class("PolyhedronHeroInfoSettingTogglee", BaseSettingToggle)

function PolyhedronHeroInfoSettingTogglee:GetName()
	return "PolyhedronHeroInfo"
end

function PolyhedronHeroInfoSettingTogglee:UIClass()
	return PolyhedronHeroInfoSettingView
end

function PolyhedronHeroInfoSettingTogglee:GetPath()
	return "Widget/System/PolyhedronBattle/PolyhedronContingentUI"
end

function PolyhedronHeroInfoSettingTogglee:Order()
	return 10
end

function PolyhedronHeroInfoSettingTogglee:RedPointKey()
	return nil
end

function PolyhedronHeroInfoSettingTogglee:Image()
	return getSprite("Atlas/SettingAtlas", "icon_setting10")
end

function PolyhedronHeroInfoSettingTogglee:GetParams()
	return nil
end

function PolyhedronHeroInfoSettingTogglee:IsSetting()
	return false
end

return PolyhedronHeroInfoSettingTogglee
