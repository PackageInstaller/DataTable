local var_0_0 = class("NewEducateMapEventCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.eventId

	if getProxy(NewEducateProxy):GetCurChar():GetFSM():CheckPriorityStystem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29064, {
		id = var_1_0.id,
		event = var_1_0.eventId
	}, 29065, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy)

			var_2_0:Cost(NewEducateHelper.Config2Drop(pg.child2_site_event_group[var_1_1].event_cost))

			local var_2_1 = var_2_0:GetCurChar()

			var_2_1:AddEventRecord(var_1_1)

			local var_2_2 = var_2_1:GetFSM()

			var_2_2:SetCurNode(arg_2_0.first_node)
			var_2_2:SetSystemNo(NewEducateFSM.SYSTEM.MAP)

			local var_2_3 = var_2_2:GetState(NewEducateFSM.SYSTEM.MAP)

			var_2_3:SetSiteState({
				key = NewEducateConst.SITE_STATE_TYPE.EVENT,
				value = var_1_1
			})
			var_2_3:FinishEvent(var_1_1)
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_MAP_EVENT_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				node = arg_2_0.first_node
			})
			pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataSite(var_2_1.id, var_2_1:GetGameCnt(), var_2_1:GetRoundData().round, 2, var_1_1))
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_MapEvent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
