local MainTechBtn = class("MainTechBtn", import(".MainBaseBtn"))

function MainTechBtn:OnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.SELTECHNOLOGY)

	return
end

return MainTechBtn
