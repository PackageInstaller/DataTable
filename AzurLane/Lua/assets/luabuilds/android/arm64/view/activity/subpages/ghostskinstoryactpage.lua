local var_0_0 = class("GhostSkinStoryActPage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.btnList:Find("activity"), function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GHOSTSKINPAGE)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	setActive(arg_3_0._tf:Find("AD/redDot"), GhostSkinPageLayer.IsShowRed())

	return
end

return var_0_0
