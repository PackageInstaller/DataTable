local MaoxiV3PtPage = class("MaoxiV3PtPage", import(".TemplatePage.PtTemplatePage"))

function MaoxiV3PtPage:OnUpdateFlush()
	MaoxiV3PtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetLevelProgress()
	local var_1_3, var_1_4, var_1_5 = self.ptData:GetResProgress()

	setText(self.step, setColorStr(var_1_0, COLOR_WHITE) .. "/" .. var_1_1)
	setText(self.progress, (var_1_5 >= 1 and setColorStr(var_1_3, COLOR_GREEN) or setColorStr(var_1_3, COLOR_WHITE)) .. "/" .. var_1_4)

	return
end

return MaoxiV3PtPage
