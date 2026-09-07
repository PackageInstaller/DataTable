local XixueguiSkinPagere = class("XixueguiSkinPagere", import(".TemplatePage.SkinTemplatePage"))

function XixueguiSkinPagere:OnUpdateFlush()
	XixueguiSkinPagere.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return XixueguiSkinPagere
