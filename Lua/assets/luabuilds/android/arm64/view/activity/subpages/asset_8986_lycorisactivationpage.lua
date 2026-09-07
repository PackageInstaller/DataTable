local LycorisActivationPage = class("LycorisActivationPage", import(".TemplatePage.SkinTemplatePage"))

function LycorisActivationPage:OnUpdateFlush()
	LycorisActivationPage.super.OnUpdateFlush(self)
	self:PlayStory()
	setText(self.dayTF, tostring(self.nday) .. "/7")

	return
end

return LycorisActivationPage
