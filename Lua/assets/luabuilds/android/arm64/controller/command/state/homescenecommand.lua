local var_0_0 = class("HomeSceneCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = Context.New()

	var_1_0:extendData((arg_1_1:getType()))
	SCENE.SetSceneInfo(var_1_0, (arg_1_1:getBody()))

	var_1_0.cleanStack = true

	arg_1_0:sendNotification(GAME.LOAD_SCENE, {
		prevContext = getProxy(ContextProxy):getCurrentContext(),
		context = var_1_0
	})

	return
end

return var_0_0
