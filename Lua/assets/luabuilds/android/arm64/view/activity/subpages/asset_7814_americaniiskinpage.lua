local AmericanIISkinPage = class("AmericanIISkinPage", import(".TemplatePage.SkinTemplatePage"))

function AmericanIISkinPage:OnUpdateFlush()
	AmericanIISkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return AmericanIISkinPage
