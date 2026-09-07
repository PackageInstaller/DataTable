local FrancePTPage = class("FrancePTPage", import(".TemplatePage.PtTemplatePage"))

function FrancePTPage:OnUpdateFlush()
	FrancePTPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_0, "#E7E1CCFF") .. "/" .. var_1_1)

	return
end

return FrancePTPage
