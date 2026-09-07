local PrincetonPtPage = class("PrincetonPtPage", import(".TemplatePage.SpTemplatePage"))

function PrincetonPtPage:OnUpdateFlush()
	PrincetonPtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetLevelProgress()
	local var_1_3, var_1_4, var_1_5 = self.ptData:GetResProgress()

	setText(self.step, setColorStr(var_1_0, "#4180FFFF") .. "/" .. var_1_1)
	setText(self.progress, setColorStr(var_1_3, "#4180FFFF") .. "/" .. var_1_4)

	return
end

return PrincetonPtPage
