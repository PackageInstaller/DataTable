local AmericanPtPage = class("AmericanPtPage", import(".TemplatePage.PtTemplatePage"))

function AmericanPtPage:OnUpdateFlush()
	AmericanPtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetLevelProgress()
	local var_1_3, var_1_4, var_1_5 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_3, "#4465DEFF") .. "/" .. var_1_4)

	return
end

return AmericanPtPage
