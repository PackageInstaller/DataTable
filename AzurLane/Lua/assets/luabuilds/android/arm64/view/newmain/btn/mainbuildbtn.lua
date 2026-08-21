local var_0_0 = class("MainBuildBtn", import(".MainBaseBtn"))

function var_0_0.OnClick(arg_1_0)
	arg_1_0:emit(NewMainMediator.GO_SCENE, SCENE.GETBOAT)

	return
end

return var_0_0
