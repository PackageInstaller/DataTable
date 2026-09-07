local NeoSkinGelideliPage = class("NeoSkinGelideliPage", import(".TemplatePage.SkinTemplatePage"))

function NeoSkinGelideliPage:OnUpdateFlush()
	NeoSkinGelideliPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return NeoSkinGelideliPage
