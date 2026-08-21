local var_0_0 = class("RemoveLayersCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().context

	assert(isa(var_1_0, Context), "should be an instance of Context")
	pg.SceneMgr.GetInstance():removeLayer(arg_1_0.facade, var_1_0, function()
		arg_1_0:sendNotification(GAME.REMOVE_LAYER_DONE, var_1_0)
		existCall(var_0.callback)

		return
	end)

	return
end

return var_0_0
