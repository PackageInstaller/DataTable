local var_0_0 = class("MainFormationBtn", import(".MainBaseBtn"))

function var_0_0.OnClick(arg_1_0)
	arg_1_0:emit(NewMainMediator.GO_SCENE, SCENE.BIANDUI, {
		fleetId = 1
	})

	return
end

function var_0_0.IsFixed(arg_2_0)
	return true
end

return var_0_0
