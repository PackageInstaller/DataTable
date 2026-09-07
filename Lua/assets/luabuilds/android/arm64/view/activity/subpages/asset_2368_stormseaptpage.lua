local StormSeaPtPage = class("StormSeaPtPage", import(".TemplatePage.PtTemplatePage"))

function StormSeaPtPage:OnUpdateFlush()
	StormSeaPtPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_0 .. "/" .. var_1_1, "#a6afd3"))

	return
end

return StormSeaPtPage
