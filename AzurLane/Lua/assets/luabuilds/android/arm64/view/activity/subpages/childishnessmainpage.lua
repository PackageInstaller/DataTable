local var_0_0 = class("ChildishnessMainPage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.btnList:Find("fight"), function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.KINDERGARTEN)

		return
	end)
	onButton(arg_1_0, arg_1_0.btnList:Find("shop"), function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	return
end

return var_0_0
