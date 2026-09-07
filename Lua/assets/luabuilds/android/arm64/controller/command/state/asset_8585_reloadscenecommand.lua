local ReloadSceneCommand = class("ReloadSceneCommand", pm.SimpleCommand)

function ReloadSceneCommand:execute(arg_1_1)
	local var_1_0 = getProxy(ContextProxy):popContext()

	var_1_0:extendData((arg_1_1:getBody()))
	self:sendNotification(GAME.LOAD_SCENE, {
		context = var_1_0,
		prevContext = var_1_0
	})

	return
end

return ReloadSceneCommand
