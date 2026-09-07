local YidaliV3SkinPage = class("YidaliV3SkinPage", import(".TemplatePage.SkinTemplatePage"))

function YidaliV3SkinPage:OnUpdateFlush()
	YidaliV3SkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#af9e82") .. "/" .. #self.taskGroup)
	GetImageSpriteFromAtlasAsync("ui/activityuipage/yidaliv3skinpage_atlas", "bj_" .. self.nday, self.bg)

	return
end

function YidaliV3SkinPage:GetProgressColor()
	return "#e6d17c"
end

return YidaliV3SkinPage
