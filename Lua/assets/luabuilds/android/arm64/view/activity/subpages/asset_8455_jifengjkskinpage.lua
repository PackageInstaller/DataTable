local JiFengJKSkinPage = class("JiFengJKSkinPage", import(".TemplatePage.SkinTemplatePage"))

function JiFengJKSkinPage:OnUpdateFlush()
	JiFengJKSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#EC8FBBFF") .. "/" .. #self.taskGroup)

	return
end

return JiFengJKSkinPage
