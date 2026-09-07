local YidaliV2PTPage = class("YidaliV2PTPage", import(".TemplatePage.PtTemplatePage"))

function YidaliV2PTPage:OnUpdateFlush()
	YidaliV2PTPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_1_2 >= 1 and setColorStr(var_1_0, "#f3e0a4") or var_1_0) .. "/" .. var_1_1)

	return
end

return YidaliV2PTPage
