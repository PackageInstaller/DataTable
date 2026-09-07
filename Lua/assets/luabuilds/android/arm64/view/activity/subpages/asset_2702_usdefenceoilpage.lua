local USDefenceOilPage = class("USDefenceOilPage", import(".TemplatePage.PtTemplatePage"))

function USDefenceOilPage:OnUpdateFlush()
	USDefenceOilPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_1_2 >= 1 and setColorStr(var_1_0, "#E8656BFF") or var_1_0) .. "/" .. var_1_1)

	return
end

return USDefenceOilPage
