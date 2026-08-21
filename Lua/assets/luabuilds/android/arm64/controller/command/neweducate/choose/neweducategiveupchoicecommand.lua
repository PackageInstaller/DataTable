local var_0_0 = class("NewEducateGiveUpChoiceCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(29101, {
		id = arg_1_1:getBody().id
	}, 29102, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:GetPriorityState():MarkFinish()
			var_2_0:CheckPriorityStystem()
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_GIVE_UP_CHOICE_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GiveUpChoice_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
