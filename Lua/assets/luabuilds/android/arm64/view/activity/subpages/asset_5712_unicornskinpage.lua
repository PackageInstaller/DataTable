local UnicornSkinPage = class("UnicornSkinPage", import(".TemplatePage.SkinTemplatePage"))

function UnicornSkinPage:OnUpdateFlush()
	UnicornSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return UnicornSkinPage
