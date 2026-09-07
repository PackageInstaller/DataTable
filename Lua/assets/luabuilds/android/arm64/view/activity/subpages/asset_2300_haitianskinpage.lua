local HaitianSkinPage = class("HaitianSkinPage", import(".TemplatePage.SkinTemplatePage"))

function HaitianSkinPage:OnUpdateFlush()
	HaitianSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#fcfbeb"))

	return
end

return HaitianSkinPage
