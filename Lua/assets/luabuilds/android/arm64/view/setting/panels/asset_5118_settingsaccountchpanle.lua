local SettingsAccountCHPanle = class("SettingsAccountCHPanle", import(".SettingsBasePanel"))

function SettingsAccountCHPanle:GetUIName()
	return "SettingsAccountCH"
end

function SettingsAccountCHPanle:GetTitle()
	return "注销账户"
end

function SettingsAccountCHPanle:GetTitleEn()
	return "/ Account Deactivation"
end

function SettingsAccountCHPanle:OnInit()
	onButton(self, findTF(self._tf, "delete"), function()
		pg.SdkMgr.GetInstance():DeleteAccount()

		return
	end, SFX_PANEL)

	return
end

return SettingsAccountCHPanle
