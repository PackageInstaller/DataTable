local LeMarsReOilPage = class("LeMarsReOilPage", import(".TemplatePage.PtTemplatePage"))

function LeMarsReOilPage:OnFirstFlush()
	LeMarsReOilPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function LeMarsReOilPage:OnUpdateFlush()
	LeMarsReOilPage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_3_2 >= 1 and setColorStr(var_3_0, "#1EA2ACFF") or var_3_0) .. "/" .. var_3_1)

	return
end

return LeMarsReOilPage
