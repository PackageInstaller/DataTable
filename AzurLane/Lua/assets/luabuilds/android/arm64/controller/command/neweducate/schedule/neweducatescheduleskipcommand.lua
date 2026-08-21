local var_0_0 = class("NewEducateScheduleSkipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(29046, {
		id = arg_1_1:getBody().id
	}, 29047, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):GetCurChar():GetFSM():GetState(NewEducateFSM.SYSTEM.PLAN):MarkFinish()
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_EXTRA_DROP, {
				id = var_0,
				scheduleDrops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_Schedule_Skip: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
