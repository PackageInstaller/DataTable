local var_0_0 = class("RefreshCommanderBoxesCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(CommanderProxy)

	pg.ConnectionMgr.GetInstance():Send(25034, {
		type = 0
	}, 25035, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.box_list) do
			var_1_1:updateBox((CommanderBox.New(iter_2_1, iter_2_0)))
		end

		arg_1_0:sendNotification(GAME.REFRESH_COMMANDER_BOXES_DONE)

		return
	end)

	return
end

return var_0_0
