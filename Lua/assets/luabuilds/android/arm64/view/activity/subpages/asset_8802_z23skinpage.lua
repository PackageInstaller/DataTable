local Z23SkinPage = class("Z23SkinPage", import(".TemplatePage.SkinTemplatePage"))

function Z23SkinPage:OnUpdateFlush()
	Z23SkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return Z23SkinPage
