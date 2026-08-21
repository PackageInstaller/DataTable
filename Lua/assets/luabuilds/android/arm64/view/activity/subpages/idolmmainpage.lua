local var_0_0 = class("IDOLMMainPage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)

	arg_1_0.mountainBtn = arg_1_0.btnList:Find("mountain")

	onButton(arg_1_0, arg_1_0.mountainBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.IMAS_STAGE)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
