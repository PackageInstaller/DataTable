local MainLiveBtn = class("MainLiveBtn", import(".MainBaseBtn"))

function MainLiveBtn:OnClick()
	getProxy(SystemTipProxy):SetIslandClickRecord()
	self:emit(NewMainScene.OPEN_LIVEAREA)

	return
end

return MainLiveBtn
