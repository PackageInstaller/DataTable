local MainHideBtn = class("MainHideBtn", import(".MainBaseBtn"))

function MainHideBtn:OnClick()
	self:emit(NewMainScene.HIDE, true)

	return
end

return MainHideBtn
