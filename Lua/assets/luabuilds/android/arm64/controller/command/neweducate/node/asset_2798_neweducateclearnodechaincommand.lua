local NewEducateClearNodeChainCommand = class("NewEducateClearNodeChainCommand", pm.SimpleCommand)

function NewEducateClearNodeChainCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(29032, {
		id = arg_1_1:getBody().id
	}, 29033, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):GetCurChar():InitFSM(arg_2_0.fsm)
			self:sendNotification(GAME.NEW_EDUCATE_CHECK_FSM)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_ClearNodeChain: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateClearNodeChainCommand
