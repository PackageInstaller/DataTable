local var_0_0 = class("StopBluePrintCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(TechnologyProxy)
	local var_1_3 = getProxy(TechnologyProxy):getBluePrintById(var_1_0.id)

	if not var_1_3 then
		return
	end

	if not var_1_3:isDeving() and not var_1_3:isFinished() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(63206, {
		blueprint_id = var_1_0.id
	}, 63207, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:updateStartUpTime(pg.TimeMgr.GetInstance():GetServerTime() - var_1_3.startTime)
			var_1_3:reset()
			var_1_2:updateBluePrint(var_1_3)
			arg_1_0:sendNotification(GAME.STOP_BLUEPRINT_DONE, {
				id = var_1_3.id
			})

			if var_1_1 then
				var_1_1()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("technology_stop_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
