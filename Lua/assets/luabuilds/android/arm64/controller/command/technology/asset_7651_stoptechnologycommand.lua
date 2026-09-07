local StopTechnologyCommand = class("StopTechnologyCommand", pm.SimpleCommand)

function StopTechnologyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(TechnologyProxy)
	local var_1_2 = var_1_1:getTechnologyById(var_1_0.id)

	if not var_1_2 or not var_1_2:isActivate() or var_1_2:isCompleted() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(29, {
		tech_id = var_1_0.id,
		refresh_id = var_1_0.pool_id
	}, 30, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:reset()
			var_1_1:updateTechnology(var_1_2)
			self:sendNotification(GAME.STOP_TECHNOLOGY_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_stop_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return StopTechnologyCommand
