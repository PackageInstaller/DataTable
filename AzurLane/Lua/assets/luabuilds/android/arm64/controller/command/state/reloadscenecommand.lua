local var_0_0 = class("ReloadSceneCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(ContextProxy):popContext()

	var_1_0:extendData((arg_1_1:getBody()))
	arg_1_0:sendNotification(GAME.LOAD_SCENE, {
		context = var_1_0,
		prevContext = var_1_0
	})

	return
end

return var_0_0
