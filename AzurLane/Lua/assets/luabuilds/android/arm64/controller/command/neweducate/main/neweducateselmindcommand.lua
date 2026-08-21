local var_0_0 = class("NewEducateSelMindCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	if getProxy(NewEducateProxy):GetCurChar():GetFSM():CheckPriorityStystem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29090, {
		id = arg_1_1:getBody().id
	}, 29091, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:SetSystemNo(NewEducateFSM.SYSTEM.MIND)
			var_2_0:SetState(NewEducateFSM.SYSTEM.MIND, (NewEducateStateBase.New()))
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_SEL_MIND_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				node = arg_2_0.first_node
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_SelMind: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
