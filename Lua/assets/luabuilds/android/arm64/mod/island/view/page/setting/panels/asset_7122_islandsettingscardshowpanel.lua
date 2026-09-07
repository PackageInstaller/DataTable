local IslandSettingsCardShowPanel = class("IslandSettingsCardShowPanel", import("view.Setting.panels.SettingsBasePanel"))

function IslandSettingsCardShowPanel:GetUIName()
	return "IslandSettingsCardShow"
end

function IslandSettingsCardShowPanel:GetTitle()
	return i18n("grapihcs3d_setting_card_title")
end

function IslandSettingsCardShowPanel:GetTitleEn()
	return "  / ISLAND CARD SETTINGS"
end

function IslandSettingsCardShowPanel:InitTitle()
	setText(self._tf:Find("title/title_point/title_text"), self:GetTitle())

	return
end

function IslandSettingsCardShowPanel:OnInit()
	self.labelToggle = self._tf:Find("options/label/toggle")
	self.labelToggleCom = self.labelToggle:GetComponent(typeof(Toggle))

	setText(self._tf:Find("options/label/mask/Text"), i18n("grapihcs3d_setting_card_tag"))

	self.socialToggle = self._tf:Find("options/social/toggle")
	self.socialToggleCom = self.socialToggle:GetComponent(typeof(Toggle))

	setText(self._tf:Find("options/social/mask/Text"), i18n("grapihcs3d_setting_card_socialdata"))

	return
end

function IslandSettingsCardShowPanel:OnUpdate()
	local var_6_0 = getProxy(IslandProxy):GetIsland():GetSettingsAgency()

	self.labelFlag = var_6_0:GetFlagByType(IslandSettingsAgency.FLAG_TYPES.SHOW_CARD_LABEL)
	self.socialFlag = var_6_0:GetFlagByType(IslandSettingsAgency.FLAG_TYPES.SHOW_CARD_SOCIAL)

	triggerToggle(self.labelToggle, self.labelFlag == 1)
	triggerToggle(self.socialToggle, self.socialFlag == 1)

	return
end

function IslandSettingsCardShowPanel:GetFlags()
	local var_7_0 = {}

	table.insert(var_7_0, {
		type = IslandSettingsAgency.FLAG_TYPES.SHOW_CARD_LABEL,
		flag = self.labelToggleCom.isOn and 1 or 0
	})
	table.insert(var_7_0, {
		type = IslandSettingsAgency.FLAG_TYPES.SHOW_CARD_SOCIAL,
		flag = self.socialToggleCom.isOn and 1 or 0
	})

	return var_7_0
end

return IslandSettingsCardShowPanel
