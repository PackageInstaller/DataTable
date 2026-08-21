local var_0_0 = class("NewEducateClearNodeChainCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(29032, {
		id = arg_1_1:getBody().id
	}, 29033, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):GetCurChar():InitFSM(arg_2_0.fsm)
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_CHECK_FSM)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_ClearNodeChain: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
