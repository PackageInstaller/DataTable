local MainMemoryBtn = class("MainMemoryBtn", import(".MainBaseBtn"))

function MainMemoryBtn:OnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.MEDIA_COLLECTION_ENTRANCE)

	return
end

return MainMemoryBtn
