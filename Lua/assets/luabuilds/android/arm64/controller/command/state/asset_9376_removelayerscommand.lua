local RemoveLayersCommand = class("RemoveLayersCommand", pm.SimpleCommand)

function RemoveLayersCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.context

	assert(isa(var_1_0.context, Context), "should be an instance of Context")
	pg.SceneMgr.GetInstance():removeLayer(self.facade, var_1_0.context, function()
		self:sendNotification(GAME.REMOVE_LAYER_DONE, var_1_1)
		existCall(var_1_0.callback)

		return
	end)

	return
end

return RemoveLayersCommand
