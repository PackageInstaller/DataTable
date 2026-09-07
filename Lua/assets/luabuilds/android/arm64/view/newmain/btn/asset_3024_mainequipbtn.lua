local MainEquipBtn = class("MainEquipBtn", import(".MainBaseBtn"))

function MainEquipBtn:OnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.EQUIPSCENE)

	return
end

return MainEquipBtn
