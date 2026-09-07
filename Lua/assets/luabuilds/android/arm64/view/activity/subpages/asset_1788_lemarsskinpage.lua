local LeMarsSkinPage = class("LeMarsSkinPage", import(".TemplatePage.SkinTemplatePage"))

function LeMarsSkinPage:OnUpdateFlush()
	LeMarsSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return LeMarsSkinPage
