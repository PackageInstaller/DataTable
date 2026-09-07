local JapanV3SkinPage = class("JapanV3SkinPage", import(".TemplatePage.SkinTemplatePage"))

function JapanV3SkinPage:OnUpdateFlush()
	JapanV3SkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#f7ecd9") .. "/" .. #self.taskGroup)
	GetImageSpriteFromAtlasAsync("ui/activityuipage/japanv3skinpage_atlas", "bj_" .. self.nday, self.bg:Find("painting"))

	return
end

function JapanV3SkinPage:GetProgressColor()
	return "#b37a4a"
end

return JapanV3SkinPage
