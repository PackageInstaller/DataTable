local var_0_0 = class("MainCollectionBtn", import(".MainBaseBtn"))

function var_0_0.OnClick(arg_1_0)
	arg_1_0:emit(NewMainMediator.GO_SCENE, SCENE.COLLECTSHIP)

	return
end

return var_0_0
