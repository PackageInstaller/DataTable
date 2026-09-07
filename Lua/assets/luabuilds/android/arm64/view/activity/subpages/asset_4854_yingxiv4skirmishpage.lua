local YingxiV4SkirmishPage = class("YingxiV4SkirmishPage", import(".TemplatePage.SkinTemplatePage"))

function YingxiV4SkirmishPage:OnUpdateFlush()
	YingxiV4SkirmishPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#C9463C") .. "/" .. #self.taskGroup)

	return
end

function YingxiV4SkirmishPage:GetProgressColor()
	return "#FFD97C"
end

return YingxiV4SkirmishPage
