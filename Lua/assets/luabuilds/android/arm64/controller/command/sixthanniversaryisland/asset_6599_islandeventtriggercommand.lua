local IslandEventTriggerCommand = class("IslandEventTriggerCommand", pm.SimpleCommand)

function IslandEventTriggerCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = IslandEvent.New({
		id = getProxy(SixthAnniversaryIslandProxy):GetNode(var_1_0.node_id).eventId
	})
	local var_1_2, var_1_3 = var_1_1:CheckTrigger(var_1_0.op)

	if not var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_3)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_0.act_id,
		arg1 = var_1_0.node_id,
		arg2 = var_1_0.op
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:AfterTrigger(var_1_0.op)

			local var_2_0 = getProxy(SixthAnniversaryIslandProxy):GetNode(var_1_0.node_id)

			var_2_0.eventId = arg_2_0.number[1]

			pg.m02:sendNotification(GAME.ISLAND_EVENT_TRIGGER_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.award_list),
				node_id = var_2_0.id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("Trigger island event failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandEventTriggerCommand
