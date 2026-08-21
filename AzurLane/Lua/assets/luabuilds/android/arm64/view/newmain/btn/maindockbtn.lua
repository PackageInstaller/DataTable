local var_0_0 = class("MainDockBtn", import(".MainBaseBtn"))

function var_0_0.OnClick(arg_1_0)
	arg_1_0:emit(NewMainMediator.GO_SCENE, SCENE.DOCKYARD, {
		mode = DockyardScene.MODE_OVERVIEW
	})

	return
end

return var_0_0
