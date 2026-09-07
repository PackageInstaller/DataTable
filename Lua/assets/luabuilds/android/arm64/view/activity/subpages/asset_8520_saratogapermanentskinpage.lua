local SaratogaPermanentSkinPage = class("SaratogaPermanentSkinPage", import(".TemplatePage.PtTemplatePage"))

function SaratogaPermanentSkinPage:OnUpdateFlush()
	SaratogaPermanentSkinPage.super.OnUpdateFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_0, "#FF8DB5") .. "/" .. var_1_1)
	setText(self.bg:Find("Text"), i18n("activity_kill"))

	return
end

return SaratogaPermanentSkinPage
