local JoinQueueTechnologyCommand = class("JoinQueueTechnologyCommand", pm.SimpleCommand)

function JoinQueueTechnologyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = getProxy(TechnologyProxy)

	if #var_1_2.queue >= TechnologyConst.QUEUE_TOTAL_COUNT then
		return
	end

	local var_1_3 = var_1_2:getTechnologyById(var_1_0.id)

	if not var_1_3 or not var_1_3:isActivate() or not var_1_3:finishCondition() or var_1_3:isCompleted() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(63013, {
		tech_id = var_1_0.id,
		refresh_id = var_1_0.pool_id
	}, 63014, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:moveTechnologyToQueue(var_1_1)
			var_1_2:updateTechnologys(arg_2_0.refresh_list)
			self:sendNotification(GAME.JOIN_QUEUE_TECHNOLOGY_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("technology_queue_in_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_stop_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return JoinQueueTechnologyCommand
