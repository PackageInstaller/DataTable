local SNPTPage = class("SNPTPage", import(".TemplatePage.PtTemplatePage"))

function SNPTPage:OnUpdateFlush()
	SNPTPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_1_2 >= 1 and setColorStr(var_1_0, "#0A79FFFF") or var_1_0) .. "/" .. var_1_1)

	return
end

return SNPTPage
