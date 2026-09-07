local ChangeSceneCommand = class("ChangeSceneCommand", pm.SimpleCommand)

function ChangeSceneCommand:execute(arg_1_1)
	local var_1_0 = getProxy(ContextProxy):getCurrentContext()

	var_1_0.skipBack = true

	local var_1_1 = Context.New()

	var_1_1:extendData((arg_1_1:getType()))
	SCENE.SetSceneInfo(var_1_1, (arg_1_1:getBody()))
	self:sendNotification(GAME.LOAD_SCENE, {
		prevContext = var_1_0,
		context = var_1_1
	})

	return
end

return ChangeSceneCommand
