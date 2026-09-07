local ColoringFetchCommand = class("ColoringFetchCommand", pm.SimpleCommand)

function ColoringFetchCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(26008, {
		act_id = arg_1_1:getBody().activityId
	}, 26001, function(arg_2_0)
		getProxy(ColoringProxy):netUpdateData(arg_2_0)
		self:sendNotification(GAME.COLORING_FETCH_DONE)

		return
	end)

	return
end

return ColoringFetchCommand
