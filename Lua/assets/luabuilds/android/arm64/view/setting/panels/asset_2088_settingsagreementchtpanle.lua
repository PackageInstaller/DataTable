local SettingsAgreementCHTPanle = class("SettingsAgreementCHTPanle", import(".SettingsAgreementPanle"))

function SettingsAgreementCHTPanle:OnInit()
	local var_1_0 = self._tf:Find("private")

	onButton(self, var_1_0, function()
		pg.UserAgreementMgr.GetInstance():ShowChtPrivate()

		return
	end, SFX_PANEL)

	local var_1_1 = self._tf:Find("licence")

	onButton(self, var_1_1, function()
		pg.UserAgreementMgr.GetInstance():ShowChtLicence()

		return
	end, SFX_PANEL)
	setText(var_1_0:Find("Text"), i18n("setting_label_private"))
	setText(var_1_1:Find("Text"), i18n("setting_label_licence"))

	return
end

return SettingsAgreementCHTPanle
