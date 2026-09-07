local SettingsAccountCHTPanle = class("SettingsAccountCHTPanle", import(".SettingsAccountCHPanle"))

function SettingsAccountCHTPanle:GetTitle()
	return "注銷"
end

function SettingsAccountCHTPanle:OnInit()
	SettingsAccountCHTPanle.super.OnInit(self)
	setText(findTF(self._tf, "delete/Text"), "注銷")

	return
end

return SettingsAccountCHTPanle
