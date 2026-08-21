local var_0_0 = class("ChangeSceneCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(ContextProxy):getCurrentContext()

	var_1_0.skipBack = true

	local var_1_1 = Context.New()

	var_1_1:extendData((arg_1_1:getType()))
	SCENE.SetSceneInfo(var_1_1, (arg_1_1:getBody()))
	arg_1_0:sendNotification(GAME.LOAD_SCENE, {
		prevContext = var_1_0,
		context = var_1_1
	})

	return
end

return var_0_0
