local YingxiV3VictoryPtPage = class("YingxiV3VictoryPtPage", import(".TemplatePage.PtTemplatePage"))

function YingxiV3VictoryPtPage:OnFirstFlush()
	YingxiV3VictoryPtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function YingxiV3VictoryPtPage:OnUpdateFlush()
	YingxiV3VictoryPtPage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetLevelProgress()
	local var_3_3, var_3_4, var_3_5 = self.ptData:GetResProgress()

	setText(self.step, var_3_0)
	setText(self.progress, (var_3_5 >= 1 and setColorStr(var_3_3, COLOR_GREEN) or setColorStr(var_3_3, "#e7dfc7")) .. "/" .. var_3_4)

	return
end

return YingxiV3VictoryPtPage
