local KelifulanSkinRePage = class("KelifulanSkinRePage", import(".TemplatePage.SkinTemplatePage"))

function KelifulanSkinRePage:OnUpdateFlush()
	KelifulanSkinRePage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#f56544") .. "/" .. #self.taskGroup)

	return
end

function KelifulanSkinRePage:GetProgressColor()
	return "#f56544", "#efdf1e6"
end

return KelifulanSkinRePage
