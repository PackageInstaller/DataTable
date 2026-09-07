local StartTechnologyCommand = class("StartTechnologyCommand", pm.SimpleCommand)

function StartTechnologyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(TechnologyProxy)
	local var_1_2 = var_1_1:getTechnologyById(var_1_0.id)

	if not var_1_2 then
		return
	end

	if tobool(var_1_1:getActivateTechnology()) then
		return
	end

	local var_1_3, var_1_4 = var_1_2:hasResToStart()

	if not var_1_3 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_4)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(25, {
		tech_id = var_1_0.id,
		refresh_id = var_1_0.pool_id
	}, 26, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs((var_1_2:getConfig("consume"))) do
				self:sendNotification(GAME.CONSUME_ITEM, Drop.Create(iter_2_1))
			end

			var_1_2:start(arg_2_0.time)
			var_1_1:updateTechnology(var_1_2)
			self:sendNotification(GAME.START_TECHNOLOGY_DONE, {
				technologyId = var_1_2.id
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("technology_start_up"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("technology_start_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return StartTechnologyCommand
