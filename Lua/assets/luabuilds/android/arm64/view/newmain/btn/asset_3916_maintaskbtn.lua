local MainTaskBtn = class("MainTaskBtn", import(".MainBaseBtn"))

function MainTaskBtn:OnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.TASK)

	return
end

return MainTaskBtn
