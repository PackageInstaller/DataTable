local MutsukiNewYearSkinPage = class("MutsukiNewYearSkinPage", import(".TemplatePage.SkinTemplatePage"))

function MutsukiNewYearSkinPage:OnUpdateFlush()
	MutsukiNewYearSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return MutsukiNewYearSkinPage
