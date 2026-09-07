local BulvxieerSPSkinPage = class("BulvxieerSPSkinPage", import(".TemplatePage.SkinTemplatePage"))

function BulvxieerSPSkinPage:OnUpdateFlush()
	BulvxieerSPSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#FFCBAE") .. "/" .. #self.taskGroup)

	return
end

function BulvxieerSPSkinPage:GetProgressColor()
	return "#FFCBAE"
end

return BulvxieerSPSkinPage
