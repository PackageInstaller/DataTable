local XixueguiSkinPage = class("XixueguiSkinPage", import(".TemplatePage.SkinTemplatePage"))

function XixueguiSkinPage:OnUpdateFlush()
	XixueguiSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return XixueguiSkinPage
