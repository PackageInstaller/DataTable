local MaoxiV2PtPage = class("MaoxiV2PtPage", import(".TemplatePage.PtTemplatePage"))

function MaoxiV2PtPage:OnUpdateFlush()
	MaoxiV2PtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetLevelProgress()
	local var_1_3, var_1_4, var_1_5 = self.ptData:GetResProgress()

	setText(self.step, var_1_0 .. "/" .. var_1_1)
	setText(self.progress, (var_1_5 >= 1 and setColorStr(var_1_3, "#80e4f9") or var_1_3) .. "/" .. var_1_4)
	setSlider(self.slider, 0, 1, var_1_5)

	return
end

return MaoxiV2PtPage
