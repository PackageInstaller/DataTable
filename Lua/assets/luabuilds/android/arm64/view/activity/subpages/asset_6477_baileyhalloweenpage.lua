local BaileyHalloweenPage = class("BaileyHalloweenPage", import(".TemplatePage.SkinTemplatePage"))

function BaileyHalloweenPage:OnUpdateFlush()
	BaileyHalloweenPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return BaileyHalloweenPage
