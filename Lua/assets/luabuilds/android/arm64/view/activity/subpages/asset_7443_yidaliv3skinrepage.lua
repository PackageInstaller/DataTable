local YidaliV3SkinRePage = class("YidaliV3SkinRePage", import(".TemplatePage.SkinTemplatePage"))

function YidaliV3SkinRePage:OnUpdateFlush()
	YidaliV3SkinRePage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#af9e82") .. "/" .. #self.taskGroup)
	GetImageSpriteFromAtlasAsync("ui/activityuipage/yidaliv3skinpage_atlas", "bj_" .. self.nday, self.bg)

	return
end

function YidaliV3SkinRePage:GetProgressColor()
	return "#e6d17c"
end

return YidaliV3SkinRePage
