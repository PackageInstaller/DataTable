local AmericanIISkinRePage = class("AmericanIISkinRePage", import(".TemplatePage.SkinTemplatePage"))

function AmericanIISkinRePage:OnUpdateFlush()
	AmericanIISkinRePage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return AmericanIISkinRePage
