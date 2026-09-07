local HuanMengMainPtHybridPage = class("HuanMengMainPtHybridPage", import(".TemplatePage.PreviewPtHybridTemplatePage"))

function HuanMengMainPtHybridPage:OnUpdateFlush()
	HuanMengMainPtHybridPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_0, "#bcbaec") .. "/" .. setColorStr(var_1_1, "#faf1f3"))

	return
end

return HuanMengMainPtHybridPage
