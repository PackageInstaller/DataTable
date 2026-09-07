local USDefencePTPage = class("USDefencePTPage", import(".TemplatePage.PtTemplatePage"))

function USDefencePTPage:OnUpdateFlush()
	USDefencePTPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_1_2 >= 1 and setColorStr(var_1_0, "#588CFEFF") or var_1_0) .. "/" .. var_1_1)

	return
end

return USDefencePTPage
