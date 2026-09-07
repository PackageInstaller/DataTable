local JavelinDressSkinPage = class("JavelinDressSkinPage", import(".TemplatePage.SkinTemplatePage"))

function JavelinDressSkinPage:OnUpdateFlush()
	JavelinDressSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#D57BEF") .. "/" .. #self.taskGroup)

	return
end

return JavelinDressSkinPage
