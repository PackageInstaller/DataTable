local HomeSceneCommand = class("HomeSceneCommand", pm.SimpleCommand)

function HomeSceneCommand:execute(arg_1_1)
	local var_1_0 = Context.New()

	var_1_0:extendData((arg_1_1:getType()))
	SCENE.SetSceneInfo(var_1_0, (arg_1_1:getBody()))

	var_1_0.cleanStack = true

	self:sendNotification(GAME.LOAD_SCENE, {
		prevContext = getProxy(ContextProxy):getCurrentContext(),
		context = var_1_0
	})

	return
end

return HomeSceneCommand
