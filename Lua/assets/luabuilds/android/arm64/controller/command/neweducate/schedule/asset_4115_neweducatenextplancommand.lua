local NewEducateNextPlanCommand = class("NewEducateNextPlanCommand", pm.SimpleCommand)

function NewEducateNextPlanCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.rePlay

	pg.ConnectionMgr.GetInstance():Send(29042, {
		id = var_1_0.id
	}, 29043, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:SetCurNode(arg_2_0.first_node)

			local var_2_1 = var_2_0:GetState(NewEducateFSM.SYSTEM.PLAN)

			var_2_1:SetNextPlanIdx()
			self:sendNotification(GAME.NEW_EDUCATE_NEXT_PLAN_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				node = arg_2_0.first_node,
				isFristNode = var_2_1:GetCurIdx() == var_2_1:GetIdxList()[1] or var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_NextPlan: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateNextPlanCommand
