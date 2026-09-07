local LoadSceneCommand = class("LoadSceneCommand", pm.SimpleCommand)

function LoadSceneCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	var_1_0.type = LOAD_TYPE_SCENE
	var_1_0.prevContext = var_1_0.prevContext or getProxy(ContextProxy):getCurrentContext()

	SCENE.CheckPreloadData(var_1_0, function()
		self:sendNotification(GAME.LOAD_CONTEXT, var_1_0)

		return
	end)

	return
end

return LoadSceneCommand
