local ChaoZhiPtPage = class("ChaoZhiPtPage", import(".TemplatePage.PtTemplatePage"))

function ChaoZhiPtPage:OnUpdateFlush()
	ChaoZhiPtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_0, "#ffeab7") .. setColorStr("/" .. var_1_1, "#ffda7e"))

	return
end

return ChaoZhiPtPage
