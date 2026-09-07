local ChangeRefreshTechnologysTendencyCommand = class("ChangeRefreshTechnologysTendencyCommand", pm.SimpleCommand)

function ChangeRefreshTechnologysTendencyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.pool_id
	local var_1_2 = var_1_0.tendency

	pg.ConnectionMgr.GetInstance():Send(63009, {
		id = var_1_0.pool_id,
		target = var_1_0.tendency
	}, 63010, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(TechnologyProxy):setTendency(var_1_1, var_1_2)
			self:sendNotification(GAME.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("change_technology_refresh_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return ChangeRefreshTechnologysTendencyCommand
