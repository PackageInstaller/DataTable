local ShanchengPTOilPage = class("ShanchengPTOilPage", import(".TemplatePage.PtTemplatePage"))

function ShanchengPTOilPage:OnFirstFlush()
	ShanchengPTOilPage.super.OnFirstFlush(self)

	ShanchengPTOilPage.scrolltext = self.awardTF:Find("name")

	return
end

function ShanchengPTOilPage:OnUpdateFlush()
	ShanchengPTOilPage.super.OnUpdateFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	self:SetAwardName()

	local var_2_0, var_2_1, var_2_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_2_2 >= 1 and setColorStr(var_2_0, "#A2A2A2FF") or var_2_0) .. "/" .. var_2_1)

	return
end

function ShanchengPTOilPage:SetAwardName()
	local var_4_0 = self.ptData:GetAward()

	if Item.getConfigData(var_4_0.id) then
		changeToScrollText(ShanchengPTOilPage.scrolltext, var_4_0:getName())
	else
		setActive(self.awardTF:Find("name"), false)
	end

	return
end

return ShanchengPTOilPage
