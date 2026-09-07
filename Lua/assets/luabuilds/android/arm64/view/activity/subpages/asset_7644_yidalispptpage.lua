local YidaliSPPTPage = class("YidaliSPPTPage", import(".TemplatePage.PtTemplatePage"))

function YidaliSPPTPage:OnUpdateFlush()
	YidaliSPPTPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_1_2 >= 1 and setColorStr(var_1_0, COLOR_GREEN) or setColorStr(var_1_0, COLOR_WHITE)) .. "/" .. var_1_1)

	return
end

return YidaliSPPTPage
