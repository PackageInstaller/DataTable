local EquipBoxVictoryPtPage = class("EquipBoxVictoryPtPage", import(".TemplatePage.PtTemplatePage"))

function EquipBoxVictoryPtPage:OnFirstFlush()
	EquipBoxVictoryPtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function EquipBoxVictoryPtPage:OnUpdateFlush()
	EquipBoxVictoryPtPage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_3_0, "#bff192") .. "/" .. var_3_1)

	return
end

return EquipBoxVictoryPtPage
