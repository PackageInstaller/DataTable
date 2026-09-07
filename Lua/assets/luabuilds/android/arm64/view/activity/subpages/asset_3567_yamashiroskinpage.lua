local YamashiroSkinPage = class("YamashiroSkinPage", import(".TemplatePage.SkinTemplatePage"))

function YamashiroSkinPage:OnUpdateFlush()
	YamashiroSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. setColorStr("/" .. #self.taskGroup, COLOR_WHITE))

	return
end

return YamashiroSkinPage
