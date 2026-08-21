local var_0_0 = class("GoBackCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = arg_1_1:getType() or 1
	local var_1_2 = getProxy(ContextProxy)
	local var_1_3 = var_1_2:popContext()
	local var_1_4
	local var_1_5

	while var_1_1 > 0 do
		if var_1_2:getContextCount() == 0 then
			break
		else
			var_1_4 = var_1_2:popContext()

			if var_1_4.skipBack then
				var_1_4 = nil
			else
				var_1_1 = var_1_1 - 1
			end
		end
	end

	if var_1_4 then
		var_1_5 = var_1_4.scene
	else
		var_1_4 = Context.New()
		var_1_5 = SCENE.MAINUI
	end

	var_1_4:extendData(var_1_0)
	SCENE.SetSceneInfo(var_1_4, var_1_5)
	arg_1_0:sendNotification(GAME.LOAD_SCENE, {
		isBack = true,
		prevContext = var_1_3,
		context = var_1_4
	})

	return
end

return var_0_0
