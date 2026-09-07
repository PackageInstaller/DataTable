local BisimaiStoryActRePage = class("BisimaiStoryActRePage", import(".TemplatePage.SkinTemplatePage"))

function BisimaiStoryActRePage:OnUpdateFlush()
	BisimaiStoryActRePage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#d9413d") .. setColorStr("/" .. #self.taskGroup, "#ffffff"))

	return
end

function BisimaiStoryActRePage:GetProgressColor()
	return "#ff4644", "#ffffff"
end

return BisimaiStoryActRePage
