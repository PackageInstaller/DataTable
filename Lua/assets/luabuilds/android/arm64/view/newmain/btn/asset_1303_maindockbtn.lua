local MainDockBtn = class("MainDockBtn", import(".MainBaseBtn"))

function MainDockBtn:OnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.DOCKYARD, {
		mode = DockyardScene.MODE_OVERVIEW
	})

	return
end

return MainDockBtn
