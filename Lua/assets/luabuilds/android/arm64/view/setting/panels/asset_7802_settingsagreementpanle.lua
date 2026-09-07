local SettingsAgreementPanle = class("SettingsAgreementPanle", import(".SettingsBasePanel"))

function SettingsAgreementPanle:GetUIName()
	return "SettingsAgreement"
end

function SettingsAgreementPanle:GetTitle()
	return i18n("Settings_title_agreement")
end

function SettingsAgreementPanle:GetTitleEn()
	return "  / VIEW AGREEMENT"
end

function SettingsAgreementPanle:OnInit()
	onButton(self, self._tf:Find("private"), function()
		pg.SdkMgr.GetInstance():ShowPrivate()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("licence"), function()
		pg.SdkMgr.GetInstance():ShowLicence()

		return
	end, SFX_PANEL)

	return
end

function SettingsAgreementPanle:OnUpdate()
	return
end

return SettingsAgreementPanle
