local BisimaiStoryActPage = class("BisimaiStoryActPage", import(".TemplatePage.SkinTemplatePage"))

function BisimaiStoryActPage:OnUpdateFlush()
	BisimaiStoryActPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#d9413d") .. setColorStr("/" .. #self.taskGroup, "#ffffff"))

	return
end

function BisimaiStoryActPage:GetProgressColor()
	return "#ff4644", "#ffffff"
end

return BisimaiStoryActPage
