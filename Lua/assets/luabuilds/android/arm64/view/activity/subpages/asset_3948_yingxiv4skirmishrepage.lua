local YingxiV4SkirmishRePage = class("YingxiV4SkirmishRePage", import(".TemplatePage.SkinTemplatePage"))

function YingxiV4SkirmishRePage:OnUpdateFlush()
	YingxiV4SkirmishRePage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#C9463C") .. "/" .. #self.taskGroup)

	return
end

function YingxiV4SkirmishRePage:GetProgressColor()
	return "#FFD97C"
end

return YingxiV4SkirmishRePage
