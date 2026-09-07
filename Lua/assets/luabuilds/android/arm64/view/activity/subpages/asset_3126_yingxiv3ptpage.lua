local YingxiV3PtPage = class("YingxiV3PtPage", import(".TemplatePage.PtTemplatePage"))

function YingxiV3PtPage:OnUpdateFlush()
	YingxiV3PtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetLevelProgress()
	local var_1_3, var_1_4, var_1_5 = self.ptData:GetResProgress()

	setText(self.step, setColorStr(var_1_0, "#fff5c6") .. "/" .. var_1_1)
	setText(self.progress, (var_1_5 >= 1 and setColorStr(var_1_3, COLOR_GREEN) or setColorStr(var_1_3, "#fff5c6")) .. "/" .. var_1_4)

	return
end

return YingxiV3PtPage
