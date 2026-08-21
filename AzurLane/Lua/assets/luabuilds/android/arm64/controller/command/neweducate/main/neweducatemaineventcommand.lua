local var_0_0 = class("NewEducateMainEventCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(29011, {
		id = arg_1_1:getBody().id
	}, 29012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:SetCurNode(arg_2_0.first_node)
			var_2_0:SetSystemNo(NewEducateFSM.SYSTEM.EVENT)

			if arg_2_0.first_node ~= 0 then
				arg_1_0:sendNotification(GAME.NEW_EDUCATE_NODE_START, {
					node = arg_2_0.first_node
				})
			else
				arg_1_0:sendNotification(GAME.NEW_EDUCATE_CHECK_FSM)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_MainEvent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
