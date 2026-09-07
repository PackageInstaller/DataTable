local LoadLayersCommand = class("LoadLayersCommand", pm.SimpleCommand)

function LoadLayersCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	var_1_0.type = LOAD_TYPE_LAYER

	var_1_0.context:extendData({
		isLayer = true
	})
	SCENE.CheckPreloadData(var_1_0, function()
		self:sendNotification(GAME.LOAD_CONTEXT, var_1_0)

		return
	end)

	return
end

return LoadLayersCommand
