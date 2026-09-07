local JapanV3PtPage = class("JapanV3PtPage", import(".TemplatePage.PtTemplatePage"))

function JapanV3PtPage:OnUpdateFlush()
	JapanV3PtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_0, "#1a97cb") .. "/" .. var_1_1)

	return
end

return JapanV3PtPage
