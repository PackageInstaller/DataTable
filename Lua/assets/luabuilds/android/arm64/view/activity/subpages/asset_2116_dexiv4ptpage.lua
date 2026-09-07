local DexiV4PtPage = class("DexiV4PtPage", import(".TemplatePage.PtTemplatePage"))

function DexiV4PtPage:OnUpdateFlush()
	DexiV4PtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetLevelProgress()
	local var_1_3, var_1_4, var_1_5 = self.ptData:GetResProgress()

	setText(self.progress, (var_1_5 >= 1 and setColorStr(var_1_3, COLOR_GREEN) or setColorStr(var_1_3, "#F11123")) .. setColorStr("/" .. var_1_4, "#635968"))

	return
end

return DexiV4PtPage
