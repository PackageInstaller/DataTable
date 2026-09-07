local LongwuSkinPage = class("LongwuSkinPage", import(".TemplatePage.SkinTemplatePage"))

function LongwuSkinPage:OnUpdateFlush()
	LongwuSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#fcfbeb"))

	return
end

function LongwuSkinPage:GetProgressColor()
	return "#1d5073", "#1d5073"
end

return LongwuSkinPage
