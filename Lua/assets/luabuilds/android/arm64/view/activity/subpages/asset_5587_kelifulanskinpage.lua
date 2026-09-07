local KelifulanSkinPage = class("KelifulanSkinPage", import(".TemplatePage.SkinTemplatePage"))

function KelifulanSkinPage:OnUpdateFlush()
	KelifulanSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#f56544") .. "/" .. #self.taskGroup)

	return
end

function KelifulanSkinPage:GetProgressColor()
	return "#f56544", "#efdf1e6"
end

return KelifulanSkinPage
