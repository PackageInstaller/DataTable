local FairyTaleSkinPage = class("FairyTaleSkinPage", import(".TemplatePage.SkinTemplatePage"))

function FairyTaleSkinPage:OnUpdateFlush()
	FairyTaleSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return FairyTaleSkinPage
