local PittsburghPtPage = class("PittsburghPtPage", import(".TemplatePage.PtTemplatePage"))

function PittsburghPtPage:OnUpdateFlush()
	PittsburghPtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_0, "#6ea4f5") .. "/" .. var_1_1)

	return
end

return PittsburghPtPage
