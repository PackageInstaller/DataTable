local var_0_0 = class("NewEducateGiveUpEntryUpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(29124, {
		id = arg_1_1:getBody().id
	}, 29125, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:GetPriorityState():MarkFinish()
			var_2_0:CheckPriorityStystem()
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_GIVE_UP_ENTRY_UP_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GiveUpEntry_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
