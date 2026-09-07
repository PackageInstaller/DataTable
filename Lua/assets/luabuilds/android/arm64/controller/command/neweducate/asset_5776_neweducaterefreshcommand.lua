local NewEducateRefreshCommand = class("NewEducateRefreshCommand", pm.SimpleCommand)

function NewEducateRefreshCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(29092, {
		id = var_1_0.id,
		difficulty = var_1_0.difficulty
	}, 29093, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):RefreshChar(var_1_1, arg_2_0.tb)
			self:sendNotification(GAME.NEW_EDUCATE_REFRESH_DONE, {
				id = var_1_1
			})
			existCall(var_1_2)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_Refresh: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateRefreshCommand
