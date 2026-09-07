local YingxiV4FrameRePage = class("YingxiV4FrameRePage", import(".TemplatePage.NewFrameTemplatePage"))

function YingxiV4FrameRePage:OnFirstFlush()
	YingxiV4FrameRePage.super.OnFirstFlush(self)
	setActive(self.switchBtn, false)

	return
end

return YingxiV4FrameRePage
