local var_0_0 = class("NewEducateTriggerNodeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.branch or 0
	local var_1_3

	if not var_1_0.costs then
		var_1_3 = {}
	end

	pg.ConnectionMgr.GetInstance():Send(29030, {
		id = var_1_0.id,
		branch = var_1_2
	}, 29031, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):Costs(var_1_3)

			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			getProxy(NewEducateProxy):GetCurChar():GetFSM():SetCurNode(arg_2_0.next_node)
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_NEXT_NODE, {
				node = arg_2_0.next_node,
				drop = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				noNextCb = function()
					if arg_2_0.next_node == 0 then
						if var_2_0:GetSystemNo() == NewEducateFSM.SYSTEM.PLAN then
							local var_3_0 = var_2_0:GetState(NewEducateFSM.SYSTEM.PLAN)

							if var_3_0:IsFinish() then
								arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_EXTRA_DROP, {
									id = var_1_1,
									scheduleDrops = var_3_0:GetDrops()
								})
							else
								arg_1_0:sendNotification(GAME.NEW_EDUCATE_NEXT_PLAN, {
									id = var_1_1
								})
							end
						else
							arg_1_0:sendNotification(GAME.NEW_EDUCATE_CHECK_FSM)
						end
					end

					return
				end
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_TriggerNode: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
